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
      login_user!(@user) 
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
