class CoinRelationship < ApplicationRecord
  belongs_to :user, class_name: "User"
  belongs_to :coin, class_name: "Coin"
  validates :user_id, presence: true
  validates :coin_id, presence: true
end
