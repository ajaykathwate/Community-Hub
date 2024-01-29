class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :video_post

  after_create_commit {broadcast_append_to self.video_post}

  validates :content, presence: true

end
