class HomeController < ApplicationController
  before_action :set_user

  def index
    @search = params[:search]
    return @books = Book.all.order(:last_name) if @search.blank?

    @author = @search[:author_title].strip
    @books = Book.search_by_author_title(@author)
  end

  private

  def set_user
    @user = current_user
  end
end
