class ChatRoom < ApplicationRecord

  belongs_to :community, class_name: "Community"

  has_many :messages, dependent: :destroy

end
