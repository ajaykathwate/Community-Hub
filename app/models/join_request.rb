class JoinRequest < ApplicationRecord
  belongs_to :user
  belongs_to :community
end
