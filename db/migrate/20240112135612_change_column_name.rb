class ChangeColumnName < ActiveRecord::Migration[7.1]
  def change
    rename_column :communities, :bout, :about
  end
end
