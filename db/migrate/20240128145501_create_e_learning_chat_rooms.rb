class CreateELearningChatRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :e_learning_chat_rooms do |t|
      t.integer :community_id

      t.timestamps
    end
  end
end
