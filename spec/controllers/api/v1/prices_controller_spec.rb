require "rails_helper"

RSpec.describe Api::V1::PricesController, type: :controller do
  describe "GET #index" do

    it "should return all of the sites and prices for a book" do
      book = Book.create(name: 'The Great Catsby', author: 'John Doe', isbn_10: '1234567890')
      site = Site.create(name: 'Amazon')
      Location.create(book: book, site: site)
      price1 = Price.create(price: '$10.20', book: book)
      price2 = Price.create(price: '$8.23', book: book)
      SitePrice.create(site: site, price: price1)
      SitePrice.create(site: site, price: price2)
      get :index, params: { book_id: book.id }
      json = JSON.parse(response.body)

      expect(json.length).to eq(2)
      expect(json[0][0]["name"]).to eq("Amazon")
      expect(json[0][1]["price"]).to eq("$10.20")
      expect(json[1][0]["name"]).to eq("Amazon")
      expect(json[1][1]["price"]).to eq("$8.23")
    end
  end
end
