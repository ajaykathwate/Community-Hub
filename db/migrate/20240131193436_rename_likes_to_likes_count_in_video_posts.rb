class RenameLikesToLikesCountInVideoPosts < ActiveRecord::Migration[7.1]
  def change
    rename_column :video_posts, :likes, :likes_count
  end
end
