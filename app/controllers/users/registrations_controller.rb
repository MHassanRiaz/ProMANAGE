class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  private

  # Customize the sign-up parameters
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :name, :phone_number])
  end

  # Override the path used after sign up
  def after_sign_up_path_for(resource)
    flash[:notice] = "Welcome! You have signed up successfully."
    root_path # Redirect to the homepage
  end

  # Override the path used after updating the account
  def after_update_path_for(resource)
    flash[:notice] = "Your account has been updated successfully."
    super
  end

  # Override the path used after signing out
  def after_sign_out_path_for(resource_or_scope)
    flash[:notice] = "You have signed out successfully."
    super
  end

  protected

  # Customize the parameters permitted for sign up
  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone_number, :designation, :company_name).merge(role: "user")
  end
end
