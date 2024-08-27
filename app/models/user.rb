
class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_and_belongs_to_many :projects
  before_create :set_default_role
  validates :role, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES = %w[user admin]

  def admin?
    role == "admin"
  end
  def user?
    role == "user"
  end
  def can_view_project?(project)
    return true if admin?  # Admins can view all projects

    # Example logic to check if a user is allowed to view a project
    # Adjust this according to your actual permission logic
    project.viewable_by?(self)
  end
  # Validations for name and phone_number
  validates :name, presence: true
  validates :phone_number, presence: true
  # Set default for has_access to false
  after_initialize :set_default_access, if: :new_record?
  def allowed_to_create_projects?
    admin? || specific_role? # or you could add other conditions
  end

  def archived_projects
    # code here
  end

  def active_projects
    # code here
  end

  private
  def set_default_access
    self.has_access ||= false
  end

  def specific_role?
    # code here
  end
  private

  def set_default_role
    self.role ||= "user"
  end
end
