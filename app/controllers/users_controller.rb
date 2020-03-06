class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  def index
    @users = User.all
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Your profile has been updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to new_user_registration_path
    flash[:alert] = 'Your account has been deleted.'
  rescue ActiveRecord::DeleteRestrictionError => e
    @user.errors.add(:base, e)
    flash[:alert] = 'You cannot delete your account.'
    redirect_to user_path(@user)
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :locations)
  end
end
