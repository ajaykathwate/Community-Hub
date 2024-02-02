class RemoveVideoPostIdFromLikes < ActiveRecord::Migration[7.1]
  def change
    remove_column :likes, :video_post_id
  end
end
