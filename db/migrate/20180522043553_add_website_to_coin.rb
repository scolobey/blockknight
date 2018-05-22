class AddWebsiteToCoin < ActiveRecord::Migration[5.1]
  def change
    add_column :coins, :website, :string
  end
end
