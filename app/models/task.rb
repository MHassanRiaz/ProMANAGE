class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user, optional: true

  validates :title, :description, :deadline, :started_at, :ended_at, :task_type, :project_id, presence: true

  before_save :calculate_time_spent

  private

  def calculate_time_spent
    if started_at && ended_at
      self.time_spent = ((ended_at - started_at) / 1.hour).round  # Time spent in hours
    end
  end
end
