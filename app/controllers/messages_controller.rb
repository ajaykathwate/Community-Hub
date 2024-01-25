class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create

    @single_chatroom = ChatRoom.find(params[:chat_room_id])
    @message = @single_chatroom.messages.build(msg_params)
    @message.user = current_user

    if @message.save
      # Assuming you want to use Turbo Streams to update the messages
      turbo_stream.append :messages, partial: 'messages/message', locals: { message: @message }
    else
      # Handle validation errors or other issues
    end
  end

  def like_post
    # check for the below message which parameter is taken by params[:id]
    @message = Message.find(params[:id])
    Message.increment_counter(:likes, @message.id)
    render :nothing => true
  end

  private
  def msg_params
    params.require(:message).permit(:content, :user_id, :likes, :post_image, :file_upload)
  end


end
