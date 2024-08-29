class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :archive, :activate]
  before_action :authorize_user!, only: [:edit, :update, :archive]
  before_action :authorize_admin!, only: [:new, :create, :archive]

  def index
    if params[:tab] == "archived"
      @projects = Project.where(archived: true)
    else
      @projects = Project.where(archived: false)
    end
  end

  def activate
    @project.update(archived: false)
    redirect_to projects_path(tab: "active"), notice: "Project has been activated."
  end

  def archive
    @project.update(archived: !@project.archived?) # Toggle archived state
    flash[:notice] = @project.archived? ? "Project was successfully archived." : "Project was successfully activated."
    redirect_to projects_path(tab: params[:tab])
  end

  def new
    @project = current_user.projects.build
  end

  def create
    @project = current_user.projects.build(project_params)
    @project.user = current_user
    @project.archived = false # Ensure new projects are active by default
    if @project.save
      redirect_to @project, notice: "Project was successfully created."
    else
      render :new

    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: "Project was successfully updated."
    else
      render :edit
    end
  end

  def show
    @assigned_users = @project.users
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :client_name, :description, :technology_stack, :url,  :rate_per_hour)
  end

  def authorize_user!
    redirect_to projects_path, alert: "You are not authorized to perform this action." unless current_user.admin? || @project.user == current_user
  end

  def authorize_admin!
    redirect_to root_path, alert: "You are not authorized to create a project." unless current_user.admin?
  end
end
