class CreateTagRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :tag_relationships do |t|
      t.belongs_to :coin, foreign_key: true
      t.belongs_to :tag, foreign_key: true

      t.timestamps
    end
  end
end
