class AddPercentChangeToCoins < ActiveRecord::Migration[5.1]
  def change
    add_column :coins, :percent_change, :float
  end
end
