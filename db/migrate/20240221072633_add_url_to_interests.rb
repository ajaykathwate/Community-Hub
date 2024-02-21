class AddUrlToInterests < ActiveRecord::Migration[7.1]
  def change
    add_column :interests, :url, :string
  end
end
