class AddFieldsToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :post_image, :string
    add_column :messages, :file_upload, :string
    add_column :messages, :likes, :integer, default: 0
  end
end
