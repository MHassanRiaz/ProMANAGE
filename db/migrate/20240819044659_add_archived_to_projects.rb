class AddArchivedToProjects < ActiveRecord::Migration[7.2]
  def change
    add_column :projects, :archived, :boolean
  end
end
