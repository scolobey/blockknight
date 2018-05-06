class AddWhitepaperToCoin < ActiveRecord::Migration[5.1]
  def change
    add_column :coins, :whitepaper, :string
  end
end
