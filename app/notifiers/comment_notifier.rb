# To deliver this notification:
#
# Comment.with(record: @post, message: "New post").deliver(User.all)

class CommentNotifier < ApplicationNotifier
  # Add your delivery methods

  deliver_by :database

  # deliver_by :email do |config|
  #   config.mailer = "UserMailer"
  #   config.method = "new_post"
  # end
  #
  # bulk_deliver_by :slack do |config|
  #   config.url = -> { Rails.application.credentials.slack_webhook_url }
  # end
  #
  # deliver_by :custom do |config|
  #   config.class = "MyDeliveryMethod"
  # end

  # Add required params
  #
  # required_param :message

  def comment
    params[:message]
  end

  def name

  end

  def creator
    comment.user
  end

  def video_post
    comment.video_post
  end

  def url
    e_learning_chat_room_video_post_path(video_post.e_learning_chat_room, video_post)
  end

end
