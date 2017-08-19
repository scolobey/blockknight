class CoinRelationship < ApplicationRecord
  belongs_to :user
  belongs_to :coin
  validates :user_id, presence: true
  validates :coin_id, presence: true
end
