class AddGithubToCoin < ActiveRecord::Migration[5.1]
  def change
    add_column :coins, :github, :string
  end
end
