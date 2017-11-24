class SitemapController < ApplicationController

  def index
    # @coins = Coin.all
    @coins = Coin.find_all_by_id([17305982, 17305992, 17306282, 17306352, 17316292])

    respond_to do |format|
      format.xml
    end

  end

end
