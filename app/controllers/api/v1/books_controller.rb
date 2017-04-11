class Api::V1::BooksController < ApiController
  def index
    render json: Book.all
  end
end
