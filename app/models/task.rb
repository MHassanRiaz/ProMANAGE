class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user, optional: true
  before_save :set_rate_per_hour_if_blank
  validates :title, :description, :deadline, :task_type, :project_id, presence: true

  before_save :calculate_time_spent
  # app/models/task.rb

    validates :rate_per_hour, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

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
  # Method to set rate_per_hour based on project's rate_per_hour
  def set_rate_per_hour_if_blank
    if ended_at.present? && rate_per_hour.blank?
      self.rate_per_hour = project.rate_per_hour if project.present?
    end
  end
  def calculate_time_spent
    if started_at && ended_at
      self.time_spent = ((ended_at - started_at) / 3600).round  # Time spent in hours
    end
  end
end
