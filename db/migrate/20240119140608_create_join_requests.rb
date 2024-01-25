class CreateJoinRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :join_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :community, null: false, foreign_key: true
      t.boolean :accepted

      t.timestamps
    end
  end
end
