class AddContentToBlogPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :blog_posts, :content, :text
  end
end
