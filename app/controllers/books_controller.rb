class BooksController < ApplicationController

  # GET /books
  def index
    @books = Book.all
  end

  # GET /books/1
  def show
    @Book = Book.find(params[:id])
  end

  # GET /books/new
  def new
    @Book = Book.new
  end

  # POST /books
  def create
    @Book = Book.new(book_params)

    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      render action: 'new'
    end
  end

  # GET /books/search
  def search
    @books = Book.search(params[:query])
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def book_params
    params.require(:book).permit(:title, :author, :isbn, :price_id, :site_id)
  end
end
