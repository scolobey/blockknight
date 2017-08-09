task :news => :environment do
  require 'nokogiri'
  require 'open-uri'

#How do I do this shit asynchronously?
  Coin.find_in_batches(batch_size: 100) do |group|

    group.each do |record|
      query = "https://www.google.com/search?q=#{record.ticker}%20coin&source=lnms&tbm=nws&sa=X&ved=0ahUKEwiW2ZSm5bzVAhUIzGMKHV_gAOIQ_AUICigB&biw=1371&bih=727"
      doc = Nokogiri::HTML(open(query))

      doc.css('div.g').each do |node|
        image = ''

        puts node.css('h3.r').text

        if node.at_css('img')
          image = node.css('img').attr('src')
        end

        news = {
          title: node.css('h3.r').text,
          description: node.css('div.st').text,
          image: image,
          url: node.css('a[href]').text,
        }

        record.feed_items.first_or_create(news)
      end

    end

    sleep(5)

  end

end
