task :news => :environment do
  require 'nokogiri'
  require 'open-uri'

  Coin.find_each do |record|
    query = "https://www.google.com/search?q=#{record.ticker}%20coin&source=lnms&tbm=nws&sa=X&ved=0ahUKEwiW2ZSm5bzVAhUIzGMKHV_gAOIQ_AUICigB&biw=1371&bih=727"

    doc = Nokogiri::HTML(open(query))
    doc.css('div.g').each do |node|
      news = {
        title: node.css('h3.r').text,
        description: node.css('div.st').text,
        image: node.css('img').attr('src'),
        url: node.css('a[href]').text,
      }

      record.feed_items.first_or_create(news)
    end

  end

end
