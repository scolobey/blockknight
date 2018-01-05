class AddArchiveToCoin < ActiveRecord::Migration[5.1]
  def change
    add_column :coins, :archive, :boolean
  end
end
