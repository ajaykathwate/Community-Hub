class RemoveColumnChatroomIdFromCommunities < ActiveRecord::Migration[7.1]
  def change
    remove_column :communities, :chatroom_id
  end
end
