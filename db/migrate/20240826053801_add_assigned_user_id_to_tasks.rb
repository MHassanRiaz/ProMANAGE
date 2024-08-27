class AddAssignedUserIdToTasks < ActiveRecord::Migration[7.2]
  def change
    add_column :tasks, :assigned_user_id, :integer
  end
end
