class TagRelationship < ApplicationRecord
  belongs_to :coin
  belongs_to :tag
end
