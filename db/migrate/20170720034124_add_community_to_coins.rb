class AddCommunityToCoins < ActiveRecord::Migration[5.1]
  def change
    add_column :coins, :community, :text
  end
end
