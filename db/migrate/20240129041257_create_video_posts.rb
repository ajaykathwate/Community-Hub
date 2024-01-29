class CreateVideoPosts < ActiveRecord::Migration[7.1]
  def change
    create_table :video_posts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :e_learning_chat_room, null: false, foreign_key: true
      t.string :title
      t.integer :likes, :default => 0

      t.timestamps
    end
  end
end
