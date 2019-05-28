class SessionsController < ApplicationController
  before_action :redirect_user!, only: [:new, :create]
  
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password])

    if @user
      session_token = @user.reset_session_token!
      session[:session_token] = session_token
      redirect_to user_url(@user)
    else
      @user = User.new(
        params[:user][:email],
        params[:user][:password])

      render :new
    end
  end

  def destroy
    logout_user!
    redirect_to new_session_url
  end
end
