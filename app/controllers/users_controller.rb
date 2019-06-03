class UsersController < ApplicationController
  before_action :redirect_user!, only: [:new, :create]
  before_action :require_login!, only: [:show]

  def show
    if current_user.id == params[:id].to_i
      render :show
    else
      redirect_to user_url(current_user)
    end
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save!
      ActivationMailer.activation_email(@user).deliver_now!
      flash[:notice] = "Your account has been created. Check your email to activate your account"
      redirect_to new_session_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def activate
    @user = User.find_by(activation_token: params[:activation_token])
    @user.activate!
    login_user!(@user)
    flash[:notice] = "Successfully activated your account"
    redirect_to user_url(@user)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
