class BooksController < ApplicationController
  def index
  end

  def crawl
    require 'open-uri'
    doc = Nokogiri::HTML(open("https://www.reddit.com/"))
    render text: doc 
    # render action: 'index'
  end
end
