require "rails_helper"

RSpec.describe Api::V1::BooksController, type: :controller do
  describe "GET #index" do

    it "should return all of the books" do
      Book.create(name: 'The Great Catsby', author: 'John Doe', isbn_10: '1234567890')
      Book.create(name: 'The Catcher in the Sky', author: 'Jane Doe', isbn_10: '1234567890')

      get :index
      json = JSON.parse(response.body)

      expect(json.length).to eq(2)
      expect(json[0]["name"]).to eq("The Great Catsby")
      expect(json[1]["name"]).to eq("The Catcher in the Sky")
    end
  end
end
