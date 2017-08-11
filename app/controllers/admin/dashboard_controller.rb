class Admin::DashboardController < ApplicationController
  before_action :admin_authorize

  def index
  end
end
