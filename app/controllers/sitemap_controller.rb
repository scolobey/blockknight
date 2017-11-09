class SitemapController < ApplicationController

  def index
    @coins = Coin.all

    respond_to do |format|
      format.xml
    end

  end

end
