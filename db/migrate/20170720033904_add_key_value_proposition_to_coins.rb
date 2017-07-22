class AddKeyValuePropositionToCoins < ActiveRecord::Migration[5.1]
  def change
    add_column :coins, :key_value_proposition, :text
  end
end
