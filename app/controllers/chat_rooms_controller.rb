class ChatRoomsController < ApplicationController

  def create_chat_room
    @community = Community.find(params[:community_id])
    @chat_room = ChatRoom.new
    @chat_room.community_id = @community.id

    if @chat_room.save
      redirect_to @community
    else
      redirect_to communities_path
    end

  end

end
