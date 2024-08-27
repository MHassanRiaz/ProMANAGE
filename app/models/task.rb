class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user
  belongs_to :assigned_user, class_name: "User", optional: true

  # Enum for task types
  enum task_type: { features: "features", bugs: "bugs", chore: "chore", release: "release" }

  # Scopes
  scope :visible_to, ->(user) {
    if user.admin?
      all
    else
      where("user_id = ? OR assigned_user_id = ?", user.id, user.id)
    end
  }

  # Validations
  validates :title, :description, :deadline, :started_at, :task_type, presence: true
  validates :time_spent, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :project_id, :user_id, presence: true
  validates :end_time, presence: true

  # Callbacks
  before_save :calculate_time_spent

  # Methods
  def calculate_time_spent
    if started_at.present? && end_time.present?
      self.time_spent = ((end_time - started_at) / 1.hour).round 2
    else
      self.time_spent = 0
    end
  end
end
