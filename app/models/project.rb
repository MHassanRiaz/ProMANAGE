class Project < ApplicationRecord

  belongs_to :user
  has_and_belongs_to_many :users
  has_many :tasks
  validates :name, presence: true
  validates :description, presence: true
  scope :active, -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }
  def viewable_by?(user)
    # Implement your logic here
    # Example: Check if the user is listed in the project's allowed view list
    allowed_users.include?(user)
  end
  def archive?
    archived == true
  end

  # Add a method to manage allowed users if needed
  def allowed_user_ids
    # code here
  end

  def allowed_users
    # Example: assuming you have a list of allowed users or roles
    User.where(id: allowed_user_ids) # or however you manage access
  end
end
