
task :check_prices => :environment do
  require 'httparty'
  # Updates Coin.prices and Coin.price every minute

  while true

    @response = HTTParty.get('https://api.coinmarketcap.com/v1/ticker/?limit=0')

    @response.each do|coin|

      Coin.where(ticker: coin["symbol"]).
        first_or_create({name: coin["name"].strip, ticker: coin["symbol"].strip}).
        update(price: coin["price_usd"], rank: coin["rank"], percent_change: coin["percent_change_24h"])
      end

    puts Time.now
    sleep 60
  end
end

task :clean_delisted_coins => :environment do
  # Archives coins that have not been updated in the past 3 days.

  Coin.where("updated_at < ?", 3.days.ago).each do |coin|

    if coin.name && coin.name != ''
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
    else
      puts 'deleting ' + coin.id
      coin.delete
    end

  end

end

task :tweet_news => :environment do
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = "jBC93V7ouNdAA3zDimHI4jlv9"
    config.consumer_secret     = "6hpCDKwk2yIj29eU6pO59cXOhuscy0CXSdusZBBsiUCOnWEdSu"
    config.access_token        = "888622546009989120-AGmOjSsSrHWpXqUkIb5rr4EhpMekgvp"
    config.access_token_secret = "eXyQ6MJDVRGilXG9UhSDMTIomhnuohGflZ10NoHDyaPuR"
  end

  entry = FeedItem.where(approved: 1).where(tweeted: nil).order(:created_at).first

  if entry
    url = entry.url
    description = entry.title
    coin = entry.coin.ticker
    string = "#{description} - #{url} $#{coin}"

    entry.update(tweeted: true)

    puts string
    # client.update(string)
  end
end

task :clear_twitter_queue => :environment do
  FeedItem.all.each do |item|
    item.update(tweeted: true)
  end
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

# This should work for now, but it may be more efficient to check for price gaps
# and integrate price hunting with the price checking.
task :load_historical_prices => :environment do
  require 'httparty'

  timespan = 60*60*24*730
  current_time = Time.now

  #get a list of coins to update (not archived, ordered by last update)
  @coin_set = assemble_update_list()

  @coin_set.each do |coin|

    if coin.previous_update
      timeDifference = current_time - coin.previous_update

      if timeDifference < timespan
        timespan = (timeDifference + 1.day).to_i
      end
    end

    puts coin.ticker

    @response = HTTParty.get('https://min-api.cryptocompare.com/data/histoday?aggregate=1&e=CCCAGG&extraParams=CryptoCompare&fsym=' + coin.ticker + '&limit=' + timespan.to_s + '&tryConversion=false&tsym=USD')

    @response['Data'].each do|price|
      coin.prices.create(time: Time.at(price["time"]), value: price["close"])
    end

    sleep 10
  end
end

def assemble_update_list
  coin_set_updated = Coin.where("archive != ? or archive is null", 1).where("previous_update is not null").order("previous_update DESC")
  coin_set_null = Coin.where("archive != ? or archive is null", 1).where("previous_update is null")

  (coin_set_null + coin_set_updated).first(10)
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

task :fix_delisted => :environment do
  Coin.where(rank: nil).each do |coin|
    coin.update(archive: 1)
  end
end

task :meltdown => :environment do
  Price.delete_all
  TagRelationship.delete_all
  Tag.delete_all
  FeedItem.delete_all
  Coin.delete_all
end
