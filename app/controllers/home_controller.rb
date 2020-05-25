class HomeController < ApplicationController
  before_action :set_user

  def index
    @search = params[:search]
    return @all_books = Book.all.order(:author) if @search.blank?

    @author = @search[:author].strip
    @all_books = Book.where('author collate "en_US" ILIKE ?', "%#{@author}%")
  end

  private

  def set_user
    @user = current_user
  end
end
