class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :video_call
end
