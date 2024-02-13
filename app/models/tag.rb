class Tag < ApplicationRecord
    has_many :taggables, dependent: :destroy
    has_many :video_posts, through: :taggables
end
