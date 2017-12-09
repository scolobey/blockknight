class UsersController < ApplicationController
  before_action :get_users

  def index

  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to root_url, notice: "Welcome. Glad to have you along."
    else
      redirect_to '/signup'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def get_users
    if admin_authorize
      @users = User.order(:created_at).page params[:page]
    else
      redirect_to coins_path
    end
  end
end
