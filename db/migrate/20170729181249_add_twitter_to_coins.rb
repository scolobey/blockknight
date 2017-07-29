class AddTwitterToCoins < ActiveRecord::Migration[5.1]
  def change
    add_column :coins, :twitter, :string
  end
end
