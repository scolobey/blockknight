class AddConcernsToCoin < ActiveRecord::Migration[5.1]
  def change
    add_column :coins, :concerns, :text
  end
end
