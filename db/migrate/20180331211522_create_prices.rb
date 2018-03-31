class CreatePrices < ActiveRecord::Migration[5.1]
  def change
    create_table :prices do |t|
      t.references :coin, foreign_key: true
      t.datetime :time
      t.integer :value

      t.timestamps
    end
  end
end
