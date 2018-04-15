require 'faker'

FactoryBot.define do
  factory :coin do |f|
    f.name "Bitcoin"
    f.ticker "BTC"
    f.description "Bitcoin is a worldwide network of mysanthropic unicorns"
    f.team "Satoshi Nakamoto"
    f.price 2863.47
    f.percent_change 4.6
    f.key_value_proposition "The coin with the largest purple tetrahedron in the universe"
    f.supply "21 bagillion"
    f.community "platinum entity"
    f.twitter "@buttnugget"
  end

  # factory :coin do |f|
  #   f.name { Faker::Name.first_name }
  #   f.ticker { Faker::Name.first_name }
  #   f.description "Bitcoin is a worldwide network of mysanthropic unicorns"
  #   f.team "Satoshi Nakamoto"
  #   f.price 2863.47
  #   f.percent_change 4.6
  #   f.key_value_proposition "The coin with the largest purple tetrahedron in the universe"
  #   f.supply "21 bagillion"
  #   f.community "platinum entity"
  #   f.twitter "@buttnugget"
  #   f.concerns "divergent mental progeny"
  # end
end
