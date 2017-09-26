class Coin < ApplicationRecord
  has_many :feed_items, dependent: :destroy
  has_many :coin_relationships
  has_many :users, through: :coin_relationships

  def followed?(user)
    return self.users.map(&:id).include? user.id
  end

  def increased?
    if percent_change && percent_change > 0
      return true
    else
      return false
    end
  end

  def to_param
    name
  end
end
