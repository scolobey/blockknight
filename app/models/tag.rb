class Tag < ApplicationRecord
  has_many :tag_relationships
  has_many :coins, through: :tag_relationships
end
