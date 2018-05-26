class ChangeCoinPricesUpdatedAtTypeToDatetime < ActiveRecord::Migration[5.1]
  def change
    change_column :coins, :prices_updated_at, :datetime
  end
end
