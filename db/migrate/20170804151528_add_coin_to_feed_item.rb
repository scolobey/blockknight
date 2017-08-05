class AddCoinToFeedItem < ActiveRecord::Migration[5.1]
  def change
    add_column :feed_items, :coin_id, :integer
  end
end
