class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  before_action :authorize_admin!
  load_and_authorize_resource

  def project_assignment
    @users = User.all
    @projects = Project.all
    @available_projects_for_user = {}

    @users.each do |user|
      assigned_project_ids = user.projects.pluck(:id)
      @available_projects_for_user[user.id] = @projects.reject { |project| assigned_project_ids.include?(project.id) }
    end
  end

  def assign_project
    @user = User.find(params[:user_id])
    @project = Project.find(params[:project_id])
    if @user.projects.include?(@project)
      redirect_to project_assignment_admin_users_path, alert: "Project is already assigned to the user."
    else
      @user.projects << @project
      redirect_to project_assignment_admin_users_path, notice: "Project assigned successfully."
    end
  end

  def remove_project
    @user = User.find(params[:id])
    @project = Project.find(params[:project_id])

    if @user.projects.include?(@project)
      @user.projects.delete(@project)
      redirect_to project_assignment_admin_users_path, notice: "Project removed successfully."
    else
      redirect_to project_assignment_admin_users_path, alert: "Project was not assigned to the user."
    end
  end

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
    @user = User.find(params[:id])
    @user.update(has_access: !@user.has_access)
    redirect_to admin_users_path, notice: "User access updated."
  end

  private

  def authorize_admin!
    redirect_to root_path, alert: "You are not authorized to access this section." unless current_user&.admin?
  end

  def check_admin
    redirect_to root_path, alert: "You are not authorized to view this page." unless current_user.admin?
  end
end
