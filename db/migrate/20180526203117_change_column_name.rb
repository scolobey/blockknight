class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :coins, :prices_updated_at, :previous_update
  end
end
