class CreateFeedItems < ActiveRecord::Migration[5.1]
  def change
    create_table :feed_items do |t|
      t.string :title
      t.text :description
      t.text :image
      t.boolean :approved
      t.text :content

      t.timestamps
    end
  end
end
