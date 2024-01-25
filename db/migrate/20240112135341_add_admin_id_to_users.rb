class AddAdminIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :admin, null: true, foreign_key: {to_table: :communities}
  end
end
