class MessagesController < ApplicationController

  # allow only authenticated user to access these pages and those who has atleast three interests
  before_action :authenticate_user
  before_action :has_three_interests

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

  # cloudinary setup
  # def upload_avatar(avatar_file)
  #   self.avatar = Cloudinary::Uploader.upload(avatar_file, resource_type: :image)['url']
  # end
  # # <%= image_tag @user.avatar if @user.avatar.present? %>
  # @user.upload_avatar(params[:user][:avatar]) if params[:user][:avatar].present?

  # check if the user is authenticated
  def authenticate_user
    if !current_user
      redirect_to new_user_sessions_path
    end
  end

  # has more than three interests selected after signup
  def has_three_interests
    if current_user.interests.count < 3
      redirect_to user_interests_path(id: current_user.id)
    end
  end

end
