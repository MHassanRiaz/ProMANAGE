# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:update]
  before_action :authenticate_user!
  before_action :admin_only, only: [ :new, :create ]
  before_action :check_access, only: [ :index, :show ]
  before_action :admin_only, only: [ :edit, :update ]
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path, notice: "Profile updated successfully."
    else
      render :edit
    end
  end

  def index
    # code here
  end

  def new
    # code here
  end

  def create
    # code here
  end


  private

  def admin_only
    unless current_user.admin?
      redirect_to root_path, alert: "You are not authorized to create a project."
    end
  end

  def check_access
    unless current_user.has_access || current_user.admin?
      redirect_to root_path, alert: "You do not have access to view projects."
    end
  end
  private

  def user_params
    params.require(:user).permit(:name, :phone_number, :email, :designation, :company_name, :password, :password_confirmation)
  end
end
