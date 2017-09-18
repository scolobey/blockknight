task :check_prices => :environment do
  require 'httparty'

  @response = HTTParty.get('https://api.coinmarketcap.com/v1/ticker/')

  @response.each do|coin|

    Coin.where(ticker: coin["symbol"]).
      first_or_create({name: coin["name"], ticker: coin["symbol"]}).
      update(price: coin["price_usd"], percent_change: coin["percent_change_24h"])

  end
end

task :tweet_winner => :environment do
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = "jBC93V7ouNdAA3zDimHI4jlv9"
    config.consumer_secret     = "6hpCDKwk2yIj29eU6pO59cXOhuscy0CXSdusZBBsiUCOnWEdSu"
    config.access_token        = "888622546009989120-AGmOjSsSrHWpXqUkIb5rr4EhpMekgvp"
    config.access_token_secret = "eXyQ6MJDVRGilXG9UhSDMTIomhnuohGflZ10NoHDyaPuR"
  end

  winners = Coin.order('percent_change desc').first(3)
  string = "Biggest gains today are #{winners[0][:name]}: #{winners[0][:percent_change]}%, #{winners[1][:name]}: #{winners[1][:percent_change]}% and #{winners[2][:name]}: #{winners[2][:percent_change]}%"
  client.update(string)
end

task :tweet_loser => :environment do
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = "jBC93V7ouNdAA3zDimHI4jlv9"
    config.consumer_secret     = "6hpCDKwk2yIj29eU6pO59cXOhuscy0CXSdusZBBsiUCOnWEdSu"
    config.access_token        = "888622546009989120-AGmOjSsSrHWpXqUkIb5rr4EhpMekgvp"
    config.access_token_secret = "eXyQ6MJDVRGilXG9UhSDMTIomhnuohGflZ10NoHDyaPuR"
  end

  losers = Coin.order('percent_change asc').first(3)
  string = "Biggest losses at the moment are #{losers[0][:name]}: #{losers[0][:percent_change]}%, #{losers[1][:name]}: #{losers[1][:percent_change]}% and #{losers[2][:name]}: #{losers[2][:percent_change]}%"
  client.update(string)
end
