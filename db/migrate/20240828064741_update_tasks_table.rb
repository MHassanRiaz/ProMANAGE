class UpdateTasksTable < ActiveRecord::Migration[7.2]
  def change
    # db/schema.rb
    create_table "tasks", force: :cascade do |t|
      t.string "title"
      t.text "description"
      t.integer "time_spent"
      t.datetime "deadline"
      t.datetime "started_at"
      # Make sure ended_at is included here
      t.datetime "ended_at"
      t.string "task_type"
      t.references "project", null: false, foreign_key: true
      t.references "user", null: true, foreign_key: true

      t.timestamps
    end

  end
end
