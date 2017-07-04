task :load_phrases => :environment do
  require 'httparty'

  @response = HTTParty.get('https://api.coinmarketcap.com/v1/ticker/')

  Coin.delete_all()
  @response.each do|coin|
    Coin.create({name: coin["name"], ticker: coin["symbol"], price: coin["price_usd"]})
  end
end
