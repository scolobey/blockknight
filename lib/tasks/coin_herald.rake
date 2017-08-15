task :news => :environment do
  require 'nokogiri'
  require 'open-uri'

  FeedItem.delete_all

  Coin.find_in_batches(batch_size: 100) do |group|

    group.each do |record|
      query = "https://www.google.com/search?q=#{record.ticker}%20coin&source=lnms&tbm=nws&sa=X&ved=0ahUKEwiW2ZSm5bzVAhUIzGMKHV_gAOIQ_AUICigB&biw=1371&bih=727"
      doc = Nokogiri::HTML(open(query))

      doc.css('div.g').slice(0, 5).each do |node|
        image = ''

        if node.at_css('img')
          image = node.css('img').attr('src')
        end

        news = {
          title: node.css('h3.r').text.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: ''),
          description: node.css('div.st').text.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: ''),
          image: image,
          url: node.css('a').attr('href').text.sub(/\/url\?q=/, "").sub(/\&sa=(.*)/, "")
        }

        record.feed_items.create(news)

      end

    end

    sleep(30)

  end

end
