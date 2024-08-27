class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_active_projects, only: [:new, :edit, :create, :update]
  before_action :set_assigned_users, only: [ :new, :edit, :create, :update, :show ]

  def index
    @tasks = current_user.admin? ? Task.all : Task.visible_to(current_user)
  end


  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id

    if @task.save
      redirect_to tasks_path, notice: "Task was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = "Task was successfully updated."
      redirect_to tasks_path
    else
      flash.now[:error] = "Failed to update task."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    flash[:success] = "Task was successfully deleted."
    redirect_to tasks_path
  end

  private

  def set_task
    @task = current_user.admin? ? Task.find(params[:id]) : current_user.tasks.find(params[:id])
  end

  def set_active_projects
    if current_user.admin?
      @active_projects = Project.where(active: true, archived: false)
    else
      @active_projects = current_user.projects.where(active: true, archived: false)
    end
  end

  def set_assigned_users
    if params[:task].present? && params[:task][:project_id].present?
      project = Project.find(params[:task][:project_id])
      @assigned_users = project.users
    else
      @assigned_users = []
    end
  end




  def task_params
    params.require(:task).permit(:title, :task_type, :project_id, :assigned_user_id, :description, :time_spent, :deadline, :started_at,  :end_time)
  end
end