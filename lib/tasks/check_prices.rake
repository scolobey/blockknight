
task :check_prices => :environment do
  require 'httparty'

  while true

    @response = HTTParty.get('https://api.coinmarketcap.com/v1/ticker/?limit=0')

    @response.each do|coin|

      Coin.where(ticker: coin["symbol"]).
        first_or_create({name: coin["name"], ticker: coin["symbol"]}).
        update(price: coin["price_usd"], percent_change: coin["percent_change_24h"])
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
  puts 'wtf'
  require 'httparty'

  Coin.all.each do |coin|

    puts coin.name

    @response = HTTParty.get('https://min-api.cryptocompare.com/data/histoday?aggregate=1&e=CCCAGG&extraParams=CryptoCompare&fsym=' + coin.ticker + '&limit=730&tryConversion=false&tsym=USD')

    @response['Data'].each do|price|
      coin.prices.create(time: Time.at(price["time"]), value: price["close"])
    end

    sleep 10
  end
end

task :meltdown => :environment do
  Price.delete_all
  TagRelationship.delete_all
  Tag.delete_all
  FeedItem.delete_all
  Coin.delete_all
end
