class RenameChatroomIdColumnToChatRoomId < ActiveRecord::Migration[7.1]
  def change
    rename_column :messages, :chatroom_id, :chat_room_id
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
