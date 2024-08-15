# app/controllers/projects_controller.rb
class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_user!, only: [ :edit, :update, :destroy ]
  before_action :authorize_admin!, only: [ :new, :create ]
  def index
    @projects = current_user.admin? ? Project.all : current_user.projects
  end

  def show
  end

  def new
    @project = current_user.projects.build
  end

  def create
    @project = current_user.projects.build(project_params)
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

  def destroy
    @project.destroy
    redirect_to projects_path, notice: "Project was successfully deleted."
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def authorize_user!
    redirect_to projects_path, alert: "You are not authorized to perform this action." unless current_user.admin? || @project.user == current_user
  end
  private

  def authorize_admin!
    unless current_user.admin? || current_user.allowed_to_create_projects?
      redirect_to root_path, alert: "You are not authorized to create a project."
    end
  end
end
