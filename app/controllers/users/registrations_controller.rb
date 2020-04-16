class Users::RegistrationsController < Devise::RegistrationsController
  before_action :user_signup_params

  def new
    @user = User.new
    render 'users/new'
  end

  protected

  def user_signup_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
  end
end
