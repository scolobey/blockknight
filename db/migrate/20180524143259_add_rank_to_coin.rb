class AddRankToCoin < ActiveRecord::Migration[5.1]
  def change
    add_column :coins, :rank, :integer
  end
end
