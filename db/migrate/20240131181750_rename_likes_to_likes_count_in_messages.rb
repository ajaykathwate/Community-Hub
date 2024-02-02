class RenameLikesToLikesCountInMessages < ActiveRecord::Migration[7.1]
  def change
    rename_column :messages, :likes, :likes_count
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
