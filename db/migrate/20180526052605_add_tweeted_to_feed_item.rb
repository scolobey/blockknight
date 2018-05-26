class AddTweetedToFeedItem < ActiveRecord::Migration[5.1]
  def change
    add_column :feed_items, :tweeted, :boolean
  end
end
