class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone_number, :designation, :company_name, :role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone_number, :designation, :company_name, :role])
  end
  def user_can_create_projects?
    current_user.admin? || current_user.allowed_to_create_projects?
  end
  helper_method :user_can_create_projects? # if you want to use it in views
  private

  def can_create_projects?
    current_user.admin? || current_user.allowed_to_create_projects?
  end
end



