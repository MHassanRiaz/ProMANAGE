class Project < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :description, presence: true
  def viewable_by?(user)
    # Implement your logic here
    # Example: Check if the user is listed in the project's allowed view list
    allowed_users.include?(user)
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
