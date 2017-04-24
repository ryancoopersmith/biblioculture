class BooksController < ApplicationController
  def index
  end

  def show
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new

    if books_params['name']
      input = books_params['name']
    elsif books_params['isbn_10']
      input = books_params['isbn_10']
    elsif books_params['isbn_13']
      input = books_params['isbn_13']
    else
      flash[:notice] = 'You must supply either the title, ISBN-10 or ISBN-13'
      render action: 'new'
    end

    amazon_spider = AmazonSpider.new(input)
    ebay_spider = EbaySpider.new(input)
    alibris_spider = AlibrisSpider.new(input)
    powells_spider = PowellsSpider.new(input)

    # Make the crawler work if the search goes directly to the book show page or to the results

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
