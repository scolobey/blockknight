class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :news_feed

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    redirect_to '/login' unless current_user
  end

  def admin_authorize
    redirect_to '/login' unless current_user.try(:admin?)
  end

  def news_feed
    @news = FeedItem.where({approved: true}).order(:created_at).first(10)
  end

  def menu_opened
    true
  end

  helper_method :menu_opened
end
