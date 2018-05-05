class AddPricesUpdatedAtToCoin < ActiveRecord::Migration[5.1]
  def change
    add_column :coins, :prices_updated_at, :date
  end
end
