class VideoCall < ApplicationRecord
  belongs_to :community, optional: true
  belongs_to :user, optional: true
  has_many :participants, dependent: :destroy
end
