class BooksController < ApplicationController
  before_action :set_book, only: %i[edit update destroy]
  before_action :set_user

  def index
    @books = @user.books
  end

  def show
    @book = @user.books.find_by(id: params[:id])
  end

  def new
    @book = @user.books.new
    authorize @book
  end

  def edit
    authorize @book
  end

  def create
    @book = @user.books.create(book_params)
    authorize @book

    if @book.save
      redirect_to user_books_path(@user), notice: 'Book has been added successfully.'
    else
      render :new
    end
  end

  def update
    authorize @book
    if @book.update(book_params)
      redirect_to user_book_path(@user, @book), notice: 'Book has been updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    authorize @book
    @book.destroy
    redirect_to user_books_path(@user), notice: 'Book has been deleted.'
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
