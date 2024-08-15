class AddDesignationAndCompanyNameToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :designation, :string
    add_column :users, :company_name, :string
  end
end
