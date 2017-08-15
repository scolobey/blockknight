class AddUrlToFeedItem < ActiveRecord::Migration[5.1]
  def change
    add_column :feed_items, :url, :string
  end
end
