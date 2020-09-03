class HomeController < ApplicationController
  before_action :set_user

  def index
    @search = params[:search]
    return @books = Book.all.includes(:author).order(:last_name).references(:author) if @search.blank?

    @search_query = @search[:author_title].strip
    @books = Book.search_by_author_title(@search_query)

    flash.now[:notice] = 'There is no such book in our catalogue.' if @books.empty?
  end

  private

  def set_user
    @user = current_user
  end
end
