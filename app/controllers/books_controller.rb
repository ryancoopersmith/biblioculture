class BooksController < ApplicationController
  def index
  end

  def show
  end

  def new
    @book = Book.new
  end

  def create
    require 'open-uri'

    @book = Book.new

    if books_params['name']
      name = books_params['name']

      amazon_doc = Nokogiri::HTML(open("https://www.amazon.com/s/ref=nb_sb_noss_1?url=search-alias%3Daps&field-keywords=#{name}"))
      ebay_doc = Nokogiri::HTML(open("http://search.half.ebay.com/#{name}_W0QQ_trksidZp3030Q2em1446Q2el2686"))
      alibris_doc = Nokogiri::HTML(open("http://www.alibris.com/booksearch?keyword=#{name}&mtype=B&hs.x=0&hs.y=0&hs=Submit"))
      powells_doc = Nokogiri::HTML(open("http://www.powells.com/SearchResults?kw=title:#{name}"))

      @book.name = name
    elsif books_params['isbn_10']
      isbn_10 = books_params['isbn_10']

      amazon_doc = Nokogiri::HTML(open("https://www.amazon.com/s/ref=nb_sb_noss_1?url=search-alias%3Daps&field-keywords=#{isbn_10}"))
      ebay_doc = Nokogiri::HTML(open("http://search.half.ebay.com/#{isbn_10}_W0QQ_trksidZp3030Q2em1446Q2el2686"))
      alibris_doc = Nokogiri::HTML(open("http://www.alibris.com/booksearch?keyword=#{isbn_10}&mtype=B&hs.x=0&hs.y=0&hs=Submit"))
      # for powells get the name of the book from the alibris spider and interpolate it in the following url:
      # powells_doc = Nokogiri::HTML(open("http://www.powells.com/SearchResults?kw=title:#{name}"))

      @book.isbn_10 = isbn_10
    elsif books_params['isbn_13']
      isbn_13 = books_params['isbn_13']

      amazon_doc = Nokogiri::HTML(open("https://www.amazon.com/s/ref=nb_sb_noss_1?url=search-alias%3Daps&field-keywords=#{isbn_13}"))
      ebay_doc = Nokogiri::HTML(open("http://search.half.ebay.com/#{isbn_13}_W0QQ_trksidZp3030Q2em1446Q2el2686"))
      alibris_doc = Nokogiri::HTML(open("http://www.alibris.com/booksearch?keyword=#{isbn_13}&mtype=B&hs.x=0&hs.y=0&hs=Submit"))
      # for powells get the name of the book from the alibris spider and interpolate it in the following url:
      # powells_doc = Nokogiri::HTML(open("http://www.powells.com/SearchResults?kw=title:#{name}"))

      @book.isbn_13 = isbn_13
    else
      flash[:notice] = 'You must supply either the title, ISBN-10 or ISBN-13'
      render action: 'new'
    end

    # Make the crawler work if the search goes directly to the book show page or to the results

    entries = doc.css('.entry')
    @entriesArray = []
    entries.each do |entry|
      title = entry.css('p.title>a').text
      link = entry.css('p.title>a')[0]['href']
      @entriesArray << Entry.new(title, link)
    end

    @location = Location.new
    @site = Site.new
    @price = Price.new
    @site_price = SitePrice.new
  end

  def edit
  end

  def update
  end

  def books_params
    params.require(:book).permit(:name, :isbn_10, :isbn_13)
  end
end
