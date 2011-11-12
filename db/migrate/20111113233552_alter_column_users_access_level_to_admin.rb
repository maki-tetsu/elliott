class AlterColumnUsersAccessLevelToAdmin < ActiveRecord::Migration
  def up
    remove_column(:users, :access_level)
    add_column(:users, :admin, :boolean, :null => false)
  end

  def down
    remove_column(:users, :admin)
    add_column(:users, :access_level, :integer, :default => 1, :null => false)
    
    change_column_default(:users, :access_level, nil)
  end
end
