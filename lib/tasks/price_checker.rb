require 'httparty'

module CoinTasks
  class PriceChecker
    def start
      puts "hey little Lucy "
      # while true do
      #     puts "checking prices #{Time.now}"
      #     @response = HTTParty.get('https://api.coinmarketcap.com/v1/ticker/')
      #
      #     @response.each do|coin|
      #
      #       Coin.where(ticker: coin["symbol"]).
      #         first_or_create({name: coin["name"], ticker: coin["symbol"]}).
      #         update(price: coin["price_usd"], percent_change: coin["percent_change_24h"])
      #
      #     end
      #     sleep 60
      #  end
    end
  end
end
