class AddUrlToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :url, :string
  end
end
