class SportsChatRoom < ApplicationRecord

  belongs_to :community, class_name: "Community"

end
