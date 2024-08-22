class AddTechnologyStackToProjects < ActiveRecord::Migration[7.2]
  def change
    add_column :projects, :technology_stack, :text
  end
end
