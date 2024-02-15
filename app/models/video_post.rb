class VideoPost < ApplicationRecord

  has_one_attached :video_file

  belongs_to :user
  belongs_to :e_learning_chat_room

  has_many :taggables, dependent: :destroy
  has_many :tags, through: :taggables

  has_many :comments, dependent: :destroy

  after_create_commit {broadcast_append_to self.e_learning_chat_room}

  validates :title, :video_file, presence: true

  has_many :likes, as: :record

  def liked_by?(user)
    likes.where(user: user).any?
  end

  def like(user)
    likes.where(user: user).first_or_create
  end

  def unlike(user)
    likes.where(user: user).destroy_all
  end

  scope :containing, ->(query){where("title LIKE ?", "%#{query}%")}

end
