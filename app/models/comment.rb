class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :video_post

  after_create_commit {broadcast_prepend_to self.video_post}

  validates :content, presence: true

  has_noticed_notifications

  after_create_commit { broadcast_notifications }

  private

  def broadcast_notifications
    return if user == video_post.user

    CommentNotifier.with(message: self).deliver_later(video_post.user)

    broadcast_prepend_to "notifications_#{video_post.user.id}",
      target: "notifications_#{video_post.user.id}",
      partial: "comment_notifier/notifications/notification",
      locals: {user:, video_post:, unread: true }
  end

end
