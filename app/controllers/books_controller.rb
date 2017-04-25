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
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new

    if books_params['name'] != ''
      google_spider = GoogleSpider.new(name: books_params['name'])
    elsif books_params['isbn_10'] != ''
      google_spider = GoogleSpider.new(isbn_10: books_params['isbn_10'])
    elsif books_params['isbn_13'] != ''
      google_spider = GoogleSpider.new(isbn_13: books_params['isbn_13'])
      @book.isbn_13 = google_spider.isbn_13
    else
      flash[:notice] = 'You must supply either the title, ISBN-10 or ISBN-13'
      render action: 'new'
    end

    google_spider.find_book

    @book.name = google_spider.name
    @book.author = google_spider.author
    @book.image = google_spider.image
    @book.isbn_10 = google_spider.isbn_10

    google_spider.scrape_prices_and_sites.each do |site|
      book_site = Site.new(name: site[0])
      book_price = Price.new(price: site[1], book: @book)
      SitePrice.new(site: book_site, price: book_price)
      Location.new(site: book_site, book: @book)
    end

    if @book.save
      redirect_to @book
    else
      flash[:notice] = 'There was an error finding the book'
      @book = Book.new
      render action: 'new'
    end
  end

  def edit
  end

  def update
  end

  def books_params
    params.require(:book).permit(:name, :isbn_10, :isbn_13)
  end
end
