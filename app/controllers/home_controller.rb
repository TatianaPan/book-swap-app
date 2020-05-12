class HomeController < ApplicationController
  before_action :set_user

  def index
    @all_books = Book.all.order(:author)
    @search = params[:search]
    # rubocop: disable Style/GuardClause
    if @search.present?
      @author = @search[:author].strip
      @all_books = Book.where('author collate "ru_RU" ILIKE ?', "%#{@author}%")
    end
    # rubocop: enable Style/GuardClause
  end

  private

  def set_user
    @user = current_user
  end
end
