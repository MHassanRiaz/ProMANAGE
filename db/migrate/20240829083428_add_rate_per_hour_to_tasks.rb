class AddRatePerHourToTasks < ActiveRecord::Migration[7.2]
  def change
    add_column :tasks, :rate_per_hour, :integer
  end
end
