class Users::SessionsController < Devise::SessionsController
  before_action :resource_name

  def resource_name
    :user
  end

  def new
    render 'users/new'
  end
end
