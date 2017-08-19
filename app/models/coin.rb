class Coin < ApplicationRecord
  has_many :feed_items, dependent: :destroy
  has_many :coin_relationships
  has_many :users, through: :coin_relationships

  def followed?(user)
    puts self.users.map(&:id).include? user.id
    puts 'yuhbud', user.id
    return self.users.map(&:id).include? user.id
  end

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
