
FactoryBot.define do
  factory :feed_item do |f|
    f.title "Latest Surge"
    f.description "Howdee pardner. Time for a whicked good piece of pie!"
    f.image "https://fm.cnbc.com/applications/cnbc.com/resources/editorialfiles/charts/2017/08/1502718106_coindesk.jpg"
    f.approved true
    f.url "https://www.cnbc.com/2017/08/14/standpoints-ronnie-moas-raises-bitcoin-price-target-to-7500.html"
    # f.coin FactoryBot.create(:coin)
  end
end
