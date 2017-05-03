require "rails_helper"

# [X] Unauthorized users should not have access to the API endpont

RSpec.describe Api::V1::BooksController, type: :controller do
  describe "GET #index" do

    it "blocks unauthenticated access" do
      sign_in nil

      get :index

      expect(response).to redirect_to(new_user_session_path)
    end

    it "should return all of the books" do
      Book.create(name: 'The Great Catsby', author: 'John Doe', isbn_10: '1234567890')
      Book.create(name: 'The Catcher in the Sky', author: 'Jane Doe', isbn_10: '1234567890')

      sign_in

      get :index
      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json.length).to eq(2)
      expect(json[0]["name"]).to eq("The Great Catsby")
      expect(json[1]["name"]).to eq("The Catcher in the Sky")
    end
  end
end
