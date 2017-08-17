class Coin < ApplicationRecord
  has_many :feed_items, dependent: :destroy
  has_many :users, through: :coin_relationships, source: :user_id

  def increased?
    puts percent_change.class, percent_change
    if percent_change && percent_change > 0
      puts 'true'
      return true
    else
      puts 'false'
      return false
    end
  end
end
