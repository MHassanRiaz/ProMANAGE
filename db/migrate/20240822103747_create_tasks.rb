class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :time_spent
      t.datetime :deadline
      t.datetime :started_at
      # t.datetime :updated_at # REMOVE this line if it exists
      t.integer :task_type
      t.references :project, null: false, foreign_key: true
      t.timestamps # This line already creates updated_at and created_at
    end
  end
end
