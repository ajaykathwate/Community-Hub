class Message < ApplicationRecord

  belongs_to :chat_room
  belongs_to :user

  has_one_attached :post_image
  has_one_attached :file_upload

  after_create_commit {broadcast_append_to self.chat_room}

  validates :content, presence: true

end
