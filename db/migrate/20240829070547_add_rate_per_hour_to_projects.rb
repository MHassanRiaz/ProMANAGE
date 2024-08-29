class AddRatePerHourToProjects < ActiveRecord::Migration[7.2]
  def change
    add_column :projects, :rate_per_hour, :integer
  end
end
