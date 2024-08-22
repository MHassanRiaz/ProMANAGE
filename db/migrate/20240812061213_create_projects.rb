class CreateProjects < ActiveRecord::Migration[7.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.references :user, null: false, foreign_key: true # Ensure this matches your constraints
      t.timestamps
    end
  end
end
