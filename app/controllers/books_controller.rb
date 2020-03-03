class BooksController < ApplicationController
  before_action :set_book, only: %i[edit update destroy]
  before_action :set_user

  def index
    @user = set_user
    @books = @user.books
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = current_user.books.new
  end

  def edit; end

  def create
    @book = current_user.books.create(book_params)

    if @book.save
      redirect_to user_books_path(current_user), notice: 'Book has been added successfully.'
    else
      render :new
    end
  end

  def update
    if @book.update(book_params)
      redirect_to user_book_path(current_user, @book), notice: 'Book has been updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to user_books_path(current_user), notice: 'Book has been deleted.'
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :description, :isbn13, :isbn10, :release_date, :status)
  end

  def set_book
    @book = current_user.books.find_by(id: params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
