class Api::V1::PricesController < ApiController
  def index
    book = Book.find(params[:book_id])
    locations = Location.where(book: book)

    sites = []

    locations.each do |location|
      sites << location.site
    end

    prices = []

    sites.each do |site|
      site_prices = SitePrice.where(site: site)

      site_prices.each do |site_price|
        if site_price.price.book == book
          prices << [site, site_price.price]
        end
      end
    end

    render json: prices
  end
end
