class SearchController < ApplicationController
  def index

  end

  def search

    @coins = Coin.ransack(name_cont: params[:q], ticker_cont: params[:q], m: 'or')
      .result()
      .limit(5)
      .map {|a|
        {name: a.name, ticker: a.ticker, url: coin_path(a)}
      }

    render json: {coins: @coins}
  end
end
