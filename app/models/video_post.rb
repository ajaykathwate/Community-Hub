class VideoPost < ApplicationRecord

  has_one_attached :video_file

  belongs_to :user
  belongs_to :e_learning_chat_room

  has_many :comments, dependent: :destroy

  after_create_commit {broadcast_append_to self.e_learning_chat_room}

  validates :title, :video_file, presence: true

end
