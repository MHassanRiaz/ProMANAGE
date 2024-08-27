class AddActiveToProjects < ActiveRecord::Migration[7.2]
  def change
    add_column :projects, :active, :boolean
  end
end
