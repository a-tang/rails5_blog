class SessionsController < ApplicationController
  before_action :redirect_if_loggedin, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by_email params[:email]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_path, notice: "Signed In!"
    else
      flash[:alert] = "Wrong Credentials!"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to home_path, notice: "Logged Out!"
  end

  private

  def redirect_if_loggedin
    redirect_to home_path, notice: "Already logged in" if user_signed_in?
  end
end
