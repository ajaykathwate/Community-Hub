class CreateSportsChatRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :sports_chat_rooms do |t|
      t.integer :community_id

      t.timestamps
    end
  end
end
