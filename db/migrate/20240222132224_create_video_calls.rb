class CreateVideoCalls < ActiveRecord::Migration[7.1]
  def change
    create_table :video_calls do |t|
      t.references :user, foreign_key: true
      t.references :community, foreign_key: true
      t.integer :started_by_user
      t.string :iframe_link

      t.timestamps
    end
  end
end
