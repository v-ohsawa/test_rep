class RenameColumnToUser < ActiveRecord::Migration
  def change
	  rename_column :users, :group_id, :user_group_id
  end
end
