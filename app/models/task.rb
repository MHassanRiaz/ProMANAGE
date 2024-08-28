class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user, optional: true

  validates :title, :description, :deadline, :task_type, :project_id, presence: true

  before_save :calculate_time_spent

  def status
    if started_at.nil? && ended_at.nil?
      "not started"
    elsif deadline.present? && started_at.present? && ended_at.nil? && deadline < Time.current
      "delayed"
    elsif started_at.present? && ended_at.nil?
      "in progress"
    elsif started_at.present? && ended_at.present?
      "completed"
    end
  end

  private

  def calculate_time_spent
    if started_at && ended_at
      self.time_spent = ((ended_at - started_at) / 3600).round  # Time spent in hours
    end
  end
end
