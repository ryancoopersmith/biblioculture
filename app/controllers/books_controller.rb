class BooksController < ApplicationController
  def index
  end

  def show
  end

  def new
    # require 'open-uri'
    # doc = Nokogiri::HTML(open("https://www.reddit.com/"))
    #
    # entries = doc.css('.entry')
    # @entriesArray = []
    # entries.each do |entry|
    #   title = entry.css('p.title>a').text
    #   link = entry.css('p.title>a')[0]['href']
    #   @entriesArray << Entry.new(title, link)
    # end
    @book = Book.new
    @location = Location.new
    @site = Site.new
    @price = Price.new
    @site_price = SitePrice.new
    # render action: 'index'
  end

  def create
  end

  def edit
  end

  def update
  end
end
