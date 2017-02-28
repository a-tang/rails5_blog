class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :destroy]
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to home_path, notice: "Account created!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update user_params
      redirect_to home_path, notice: "Details updated!"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
