class AddAboutToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :about, :text
    add_column :users, :old_password, :text
    #Ex:- :default =>''
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
