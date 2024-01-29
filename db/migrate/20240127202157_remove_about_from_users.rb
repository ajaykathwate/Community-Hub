class RemoveAboutFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :old_password
  end
end
