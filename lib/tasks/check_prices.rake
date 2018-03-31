
task :check_prices => :environment do
  require 'httparty'

  while true
    @response = HTTParty.get('https://api.coinmarketcap.com/v1/ticker/')

    puts 'running'

    @response.each do|coin|


      @coin = Coin.where(ticker: coin["symbol"]).
        first_or_create({name: coin["name"], ticker: coin["symbol"]})
      @coin.update(price: coin["price_usd"], percent_change: coin["percent_change_24h"])


      Price.create(coin_id: @coin.id, time: DateTime.strptime(coin["last_updated"],"%s"), value: coin["price_usd"])

    end

    puts 'sleeping'

    sleep 30
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
