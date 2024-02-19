class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    @single_chatroom = ChatRoom.find(params[:chat_room_id])
    @message = @single_chatroom.messages.build(msg_params)
    @message.user = current_user

    # if @message.save
    #   puts "Message saved to DB...!"
    #   turbo_stream.append :messages, partial: 'messages/message', locals: { message: @message }
    # else
    #   # validation errors
    # end

    @message.save
    #   puts "saved message...."
    #   # html = render(partial: 'messages/message', locals: { message: @message })
    #   # ActionCable.server.broadcast("room_channel_#{@message.chat_room_id}", {html: html})
    #   # SendMessageJob.perform_later(@message)
      html = ApplicationController.render(
        partial: "messages/message",
        locals:{message: @message}
      )
      ActionCable.server.broadcast("room_channel_#{@message.chat_room_id}", {html: html} )
    # turbo_stream.append :messages, partial: 'messages/message', locals: { message: @message }
  end

  def like_post
    # check for the below message which parameter is taken by params[:id]
    @message = Message.find(params[:id])
    if @message.increment!(:likes)
    turbo_stream.replace(
      render(partial: 'messages/message', locals: { message: @message }),
      target: "message_#{@message.id}"
    )
    end
  end

  private
  def msg_params
    params.require(:message).permit(:content, :user_id, :likes, :post_image, :file_upload)
  end


end
