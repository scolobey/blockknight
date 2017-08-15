class FeedItem < ApplicationRecord
  belongs_to :coin
  validates_uniqueness_of :title
  before_save :truncate_username

  def truncate_username
    self.title = title.slice(0, 255)
    self.url = url.slice(0, 255)
  end
end
