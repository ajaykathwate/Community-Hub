class User < ApplicationRecord

  has_one_attached :profile_image

  has_secure_password

  # validations
  validates :name, presence: true, length: { minimum: 4, maximum: 255 }
  validates :username, presence: true, uniqueness: true, length: { minimum:6, maximum: 50 }, format: { with: /\A[\w]+\z/, message: "can only contain letters, numbers, and underscores" }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }

  has_many :community_users, dependent: :destroy
  has_many :communities, through: :community_users, dependent: :destroy

  has_many :join_requests, dependent: :destroy
  has_many :requested_communities, through: :join_requests, source: :community, dependent: :destroy

  has_many :messages, dependent: :destroy

  has_many :video_posts, dependent: :destroy

  has_many :comments, dependent: :destroy

  has_many :likes
  
  has_many :notifications, as: :recipient, dependent: :destroy, class_name: "Noticed::Notification"

  belongs_to :admin, class_name: "Community", foreign_key: "admin_id", optional: true

  scope :all_except, -> (user) {where.not(id: user)}
  scope :containing, ->(query){where("name LIKE ?", "%#{query}%")}

end
