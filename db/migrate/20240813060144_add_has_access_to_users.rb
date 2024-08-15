class AddHasAccessToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :has_access, :boolean
  end
end
