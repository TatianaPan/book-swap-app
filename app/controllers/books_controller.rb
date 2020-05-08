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
    @book = @user.books.new(book_params)
    authorize @book

    if @book.save
      redirect_to user_books_path(@user), notice: 'Book has been added successfully.'
    else
      render :new
    end
  end

  def update
    authorize @book

    @book.update(book_params)

    if @book.status == 'reserved'
      @book.update({ borrower_id: current_user.id })
      # after book was reserved and after it has been passed, borrower_id should remain the same
    elsif @book.status == 'borrowed'
      @book.update({ borrower_id: @book.borrower_id })
    else
      @book.update({ borrower_id: nil })
    end

    redirect_to user_book_path(@user, @book), notice: 'Book has been updated successfully.'
  end

  def reserve
    @book = @user.books.find_by(id: params[:id])
    authorize @book

    @book.update({ status: 'reserved', borrower_id: current_user.id })
    redirect_to user_book_path(@user, @book), notice: 'You reserved this book.'
  end

  def unreserve
    @book = @user.books.find_by(id: params[:id])
    authorize @book

    @book.update(status: 'available', borrower_id: nil)
    redirect_to user_book_path(@user, @book), notice: 'Book is unreserved.'
  end

  def destroy
    authorize @book
    @book.destroy

    redirect_to user_books_path(@user), notice: 'Book has been deleted.'
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :description, :isbn13, :isbn10, :release_date, :status, :borrower_id)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
