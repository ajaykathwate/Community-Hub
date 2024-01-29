class ELearningChatRoom < ApplicationRecord

  belongs_to :community, class_name: "Community"

  has_many :video_posts, dependent: :destroy

end
