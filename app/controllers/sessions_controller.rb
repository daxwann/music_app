class SessionsController < ApplicationController
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
      redirect_to bands_url
    else
      @user = User.new(
        params[:user][:email],
        params[:user][:password])

      render :new
    end
  end

  def destroy
    @user.reset_session_token!
    session[:session_token] = nil
    redirect_to bands_url
  end
end
