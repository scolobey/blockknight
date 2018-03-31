class ChangeValueToFloat < ActiveRecord::Migration[5.1]
  def change
    change_column :prices, :value, :float
  end
end
