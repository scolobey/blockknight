class CreateCoinRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :coin_relationships do |t|
      t.integer :user_id
      t.integer :coin_id

      t.timestamps
    end
    add_index :coin_relationships, :user_id
    add_index :coin_relationships, :coin_id
    add_index :coin_relationships, [:user_id, :coin_id], unique: true
  end
end
