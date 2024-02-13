class Community < ApplicationRecord

  after_update :notify_users

  has_one_attached :community_profile

  has_one :chat_room, class_name: "ChatRoom", dependent: :destroy

  has_one :e_learning_chat_room, class_name: "ELearningChatRoom", dependent: :destroy

  has_one :sports_chat_room, class_name: "SportsChatRoom", dependent: :destroy

  has_many :community_users, dependent: :destroy
  has_many :users, through: :community_users

  has_many :join_requests, dependent: :destroy
  has_many :requested_users, through: :join_requests, source: :user, dependent: :destroy

  has_one :admin, class_name: "User", foreign_key: "admin_id", dependent: :destroy

  scope :public_communities, -> {where(isPrivate: false)}
  scope :private_communities, -> {where(isPrivate: true)}

  # broadcast communities
  after_create_commit { broadcast_append_to "communities"}

  # validations for community input fields
  validates :name, :topic, :admin_id, presence: true, length: { maximum: 255 }
  validates :name, uniqueness: true
  validates :community_profile, presence: :true
  validates :about, presence: true, uniqueness: true, length: { minimum: 10, maximum: 1000 }

  def self.ransackable_attributes(auth_object = nil)
    ["about", "admin_id", "created_at", "id", "id_value", "isPrivate", "name", "topic", "updated_at"]
  end

  def notify_users
    ActionCable.server.broadcast("notifications_channel", {
        body: "#{self.name} community is been updated.",
        requireInteraction: true
    })
  end

end
