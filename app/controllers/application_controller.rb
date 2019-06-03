class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in?

  private

  def current_user
    return nil if session[:session_token].nil?

    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !current_user.nil? 
  end

  def login_user!(user)
    return unless user.activated
    token = user.reset_session_token!
    session[:session_token] = token
  end

  def logout_user!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def redirect_user!
    if current_user
      redirect_to user_url(current_user)
    end
  end

  def require_login!
    redirect_to new_session_url if current_user.nil?
  end
end
