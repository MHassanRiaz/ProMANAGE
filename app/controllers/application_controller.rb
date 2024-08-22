class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.

  allow_browser versions: :modern
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  include CanCan::ControllerAdditions

  rescue_from CanCan::AccessDenied, with: :user_not_authorized

  private

  def user_not_authorized(exception)
    flash[:alert] = exception.message || "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role])
  end

  def user_can_create_projects?
    current_user.admin? || current_user.allowed_to_create_projects?
  end
  helper_method :user_can_create_projects? # if you want to use it in views

  private

  def can_create_projects?
    current_user.admin? || current_user.allowed_to_create_projects?
  end

  def check_admin
    unless current_user.admin?
      flash[:alert] = "You are not authorized to view this page."
      redirect_to root_path
    end
  end
end
