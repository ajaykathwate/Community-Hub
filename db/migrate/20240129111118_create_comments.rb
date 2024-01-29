class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :video_post, null: false, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
