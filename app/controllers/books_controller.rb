class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]

  def index
    @books = Book.all
  end

  def show; end

  def new
    @book = Book.new
  end

  def edit; end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to books_path, notice: 'Book has been added successfully.'
    else
      render :new
    end
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'Book has been updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: 'Book has been deleted.'
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :description, :user_id, :isbn13, :isbn10, :year, :status)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
