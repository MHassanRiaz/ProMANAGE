# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

User.find_or_create_by!(email: "admin@promanage.com") do |user|
  user.name = "Administrator"
  user.phone_number = "0316-1812447"
  user.password = "admin@pro"
  user.password_confirmation = "admin@pro"
  user.designation = "Manager"
  user.company_name = "DevLinks"
  user.role = "admin"
end
