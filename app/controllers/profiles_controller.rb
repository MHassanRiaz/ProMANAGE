class ProfilesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:update]
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update]
  before_action :check_access, only: [:show, :edit, :update]
  before_action :admin_only, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Profile updated successfully."
      redirect_to profile_path
    else
      flash.now[:error] = "There was an error updating the profile."
      render :edit
    end
  end

  def index
    # code here (if needed for user profiles listing)
  end

  def new
    # code here (if needed for creating a new profile)
  end

  def create
    # code here (if needed for creating a new profile)
  end

  private

  def set_user
    @user = current_user
  end

  def check_access
    unless current_user == @user || current_user.admin?
      flash[:alert] = "You do not have access to view this resource."
      redirect_to root_path
    end
  end

  def admin_only
    unless current_user.admin?
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :phone_number, :email, :designation, :company_name, :password, :password_confirmation)
  end
end
