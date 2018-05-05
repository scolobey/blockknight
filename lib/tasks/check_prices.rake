
task :check_prices => :environment do
  require 'httparty'
  # Updates Coin.prices and Coin.price every minute

  while true

    @response = HTTParty.get('https://api.coinmarketcap.com/v1/ticker/?limit=0')

    @response.each do|coin|

      Coin.where(ticker: coin["symbol"]).
        first_or_create({name: coin["name"], ticker: coin["symbol"]}).
        update(price: coin["price_usd"], percent_change: coin["percent_change_24h"]).
        prices.create(time: Time.at(price["time"]), value: coin["price_usd"])

    end

    puts Time.now
    sleep 60
  end
end

task :tweet_winner => :environment do
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = "jBC93V7ouNdAA3zDimHI4jlv9"
    config.consumer_secret     = "6hpCDKwk2yIj29eU6pO59cXOhuscy0CXSdusZBBsiUCOnWEdSu"
    config.access_token        = "888622546009989120-AGmOjSsSrHWpXqUkIb5rr4EhpMekgvp"
    config.access_token_secret = "eXyQ6MJDVRGilXG9UhSDMTIomhnuohGflZ10NoHDyaPuR"
  end

  entry = FeedItem.where({approved: true}).order(:created_at).first
  string = "#{entry[:description]} www.blockknight.com/news"
  client.update(string)
end

task :tweet_loser => :environment do
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = "jBC93V7ouNdAA3zDimHI4jlv9"
    config.consumer_secret     = "6hpCDKwk2yIj29eU6pO59cXOhuscy0CXSdusZBBsiUCOnWEdSu"
    config.access_token        = "888622546009989120-AGmOjSsSrHWpXqUkIb5rr4EhpMekgvp"
    config.access_token_secret = "eXyQ6MJDVRGilXG9UhSDMTIomhnuohGflZ10NoHDyaPuR"
  end

  entry = FeedItem.where({approved: true}).order(:created_at).second
  string = "www.blockknight.com/news"
  client.update(string)
end

task :load_historical_prices => :environment do
  require 'httparty'

  @coin_set_updated = Coin.where("prices_updated_at is not null").order("prices_updated_at DESC")
  @coin_set_null = Coin.where("prices_updated_at is null")
  @coin_set = @coin_set_null + @coin_set_updated

  @coin_set.each do |coin|
    puts coin.name
    days = 730

    if coin.prices_updated_at
      timeDifference = Time.now.to_date - coin.prices_updated_at.to_date
      puts timeDifference +1
      if timeDifference < days
        days = timeDifference + 1
      end
    end

    coin.update({prices_updated_at: Time.now})

    @response = HTTParty.get('https://min-api.cryptocompare.com/data/histoday?aggregate=1&e=CCCAGG&extraParams=CryptoCompare&fsym=' + coin.ticker + '&limit=' + days.to_s + '&tryConversion=false&tsym=USD')

    @response['Data'].each do|price|
      puts Time.at(price["time"])
      coin.prices.create(time: Time.at(price["time"]), value: price["close"])
    end

    sleep 10
  end
end

task :update_historical_prices => :environment do
  # load prices for coins containing a time gap of > 12 hours.

end

task :meltdown => :environment do
  Price.delete_all
  TagRelationship.delete_all
  Tag.delete_all
  FeedItem.delete_all
  Coin.delete_all
end
