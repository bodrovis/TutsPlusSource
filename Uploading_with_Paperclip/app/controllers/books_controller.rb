class BooksController < ApplicationController
  before_action :set_book, only: [:show, :download]

  def index
    @books = Book.order('created_at DESC')
  end

  def new
    @book = Book.new
  end

  def show
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to books_path
    else
      render :new
    end
  end

  def download
    redirect_to @book.image.expiring_url
  end

  private

  def book_params
    params.require(:book).permit(:title, :description, :image, :author)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end