class CreateCommunities < ActiveRecord::Migration[7.1]
  def change
    create_table :communities do |t|
      t.string :name
      t.string :topic
      t.text :bout
      t.boolean :isPrivate
      t.integer :admin_id
      

      t.timestamps
    end
  end
end
