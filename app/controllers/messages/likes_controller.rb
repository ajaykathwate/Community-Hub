class Messages::LikesController < ApplicationController
  include ActionView::RecordIdentifier
  
  before_action :set_message

  def update
    if @message.liked_by?(current_user)
      @message.unlike(current_user)
    else
      @message.like(current_user)
    end
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(dom_id(@message, :likes), partial: 'messages/likes', locals:{message: @message})
       }
    end
  end

  private
  def set_message
    @message = Message.find(params[:message_id])
  end

end
