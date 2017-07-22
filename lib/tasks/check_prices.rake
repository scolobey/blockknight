task :check_prices => :environment do
  require 'httparty'

  @response = HTTParty.get('https://api.coinmarketcap.com/v1/ticker/')

  Coin.delete_all()
  @response.each do|coin|
    Coin.create({name: coin["name"], ticker: coin["symbol"], price: coin["price_usd"], percent_change: coin["percent_change_24h"]})
  end
end
