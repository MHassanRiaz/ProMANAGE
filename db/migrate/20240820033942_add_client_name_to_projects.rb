class AddClientNameToProjects < ActiveRecord::Migration[7.2]
  def change
    add_column :projects, :client_name, :string
  end
end
