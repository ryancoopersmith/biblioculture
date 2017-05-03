class BooksController < ApplicationController
  def index
  end

  def show
    @book = Book.find(params[:id])
    locations = Location.where(book: @book)

    sites = []

    locations.each do |location|
      sites << location.site
    end

    @prices = []

    sites.each do |site|
      site_prices = SitePrice.where(site: site)

      site_prices.each do |site_price|
        if site_price.price.book == @book
          @prices << [site, site_price.price]
        end
      end
    end

    current_book = @book.id
    last_book = Book.last.id
    if current_book != last_book
      next_book = (params[:id].to_i + 1).to_s
      @next = Book.find(next_book)
    end
    first_book = Book.first.id
    if current_book != first_book
      previous_book = (params[:id].to_i - 1).to_s
      @previous = Book.find(previous_book)
    end
  end

  def new
    @books = []
    10.times { @books << Book.new }
  end

  def create
    not_found_counter = 0
    @books = []
    params['books'].each do |book|
      if book['name'] != '' || book['isbn_10'] != '' || book['isbn_13'] != ''
        @book = Book.new
        if book['name'] != ''
          google_spider = GoogleSpider.new(name: books_params(book)['name'])
        elsif book['isbn_10'] != ''
          google_spider = GoogleSpider.new(isbn_10: books_params(book)['isbn_10'])
        elsif book['isbn_13'] != ''
          google_spider = GoogleSpider.new(isbn_13: books_params(book)['isbn_13'])
          @book.isbn_13 = google_spider.isbn_13
        end

        google_spider.find_book

        @book.name = google_spider.name.force_encoding('iso8859-1').encode('utf-8')
        @book.author = google_spider.author.force_encoding('iso8859-1').encode('utf-8')
        @book.image = google_spider.image
        @book.isbn_10 = google_spider.isbn_10

        if @book.save
          google_spider.scrape_prices_and_sites.each do |site|
            book_site = Site.create(name: site[0])
            book_price = Price.create(price: site[1], book: @book)
            SitePrice.create(site: book_site, price: book_price)
            Location.create(site: book_site, book: @book)
          end
          @books << @book
        else
          flash[:notice] = @book.errors.full_messages
          @books = []
          10.times { @books << Book.new }
          render action: 'new' and return 1
        end
      else
        not_found_counter += 1
      end
    end
    if not_found_counter == 10
      flash[:notice] = 'You must supply either the title, ISBN-10 or ISBN-13'
      @books = []
      10.times { @books << Book.new }
      render action: 'new'
    else
      redirect_to @books[0]
    end
  end

  def edit
  end

  def update
  end

  private

  def books_params(book_params)
    book_params.permit(:name, :isbn_10, :isbn_13)
  end
end
