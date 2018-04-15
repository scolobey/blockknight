class Price < ApplicationRecord
  belongs_to :coin
  validates_uniqueness_of :time, scope: [:coin_id]
end
