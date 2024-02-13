class Taggable < ApplicationRecord
  belongs_to :video_post
  belongs_to :tag
end
