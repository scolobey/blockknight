class AddPriceDataToCoin < ActiveRecord::Migration[5.1]
  def change
    add_column :coins, :price_data, :string
  end
end
