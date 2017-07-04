class CreateCoins < ActiveRecord::Migration[5.1]
  def change
    create_table :coins do |t|
      t.string :name
      t.string :ticker
      t.text :description
      t.text :team

      t.timestamps
    end
  end
end
