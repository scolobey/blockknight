
task :check_prices => :environment do
  require 'httparty'
  # Updates Coin.prices and Coin.price every minute

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

task :clean_delisted_coins => :environment do
  # Archives coins that have not been updated in the past 3 days.
  Coin.where("updated_at < ?", 3.days.ago).each do |coin|
    unless coin.archive == 1
      puts 'archiving ' + coin.ticker
      coin.update(archive: 1)

      coin.feed_items.create({
        title: coin.ticker + '$ delisted',
        description: 'It appears that ' + coin.name + ' was recently delisted from coinmarketcap.',
        url: 'http://blockknight.com/news',
        image: 'http://sonomasun.com/wp-content/uploads/2016/12/game_over.png'
      })
    end
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
      if timeDifference < days
        days = timeDifference + 1
      end
    end

    coin.update({prices_updated_at: Time.now})

    @response = HTTParty.get('https://min-api.cryptocompare.com/data/histoday?aggregate=1&e=CCCAGG&extraParams=CryptoCompare&fsym=' + coin.ticker + '&limit=' + days.to_s + '&tryConversion=false&tsym=USD')

    @response['Data'].each do|price|
      coin.prices.create(time: Time.at(price["time"]), value: price["close"])
    end

    sleep 10
  end
end

task :google_alerts => :environment do
  require 'rss'
  require 'open-uri'

  url = 'https://www.google.com/alerts/feeds/04999850794818449576/7424705701789871207'

  open(url) do |rss|
    feed = RSS::Parser.parse(rss)
    puts "Title: "
    feed.items.each do |item|
      puts "Item: #{item.title}"
    end
  end

end

task :meltdown => :environment do
  Price.delete_all
  TagRelationship.delete_all
  Tag.delete_all
  FeedItem.delete_all
  Coin.delete_all
end
