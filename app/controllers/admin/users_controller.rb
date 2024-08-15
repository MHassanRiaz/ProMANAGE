class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  before_action :authorize_admin!
  def index
    @users = User.all
  end

  def switch
    @user = User.find(params[:id])
    if current_user.admin?
      sign_in(@user, bypass: true) # Sign in as the selected user without password
      redirect_to root_path, notice: "Switched to #{@user.email}."
    else
      redirect_to root_path, alert: "You are not authorized to switch users."
    end
  end
  def toggle_access
    user = User.find(params[:id])
    user.update(has_access: !user.has_access)
    redirect_to admin_users_path, notice: "User access updated."
  end
  def admin_only
    redirect_to root_path, alert: "You are not authorized to access this page." unless current_user.admin?
  end
  def check_admin
    unless current_user.admin?
      redirect_to root_path, alert: "You are not authorized to view this page."
    end


    def authorize_admin!
      redirect_to root_path, alert: "Not authorized" unless current_user.admin?
    end
  end
end
