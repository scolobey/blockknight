class Coin < ApplicationRecord
  before_save :permalink
  has_many :feed_items, dependent: :destroy
  has_many :coin_relationships
  has_many :users, through: :coin_relationships
  has_many :tag_relationships
  has_many :tags, through: :tag_relationships
  has_many :prices
  validates :ticker, presence: true
  validates_uniqueness_of :name
  after_initialize :init
  serialize :price_data, Array

  def init
    self.prices_updated_at = Time.now - 10.years
  end

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
        Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end

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
   "#{id}-#{permalink}"
  end

  def permalink
   self.name
  end

end
