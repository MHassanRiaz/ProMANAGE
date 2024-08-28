class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [ :show, :edit, :update, :destroy ]
  before_action :set_active_projects, only: [ :new, :edit, :create, :update ]
  before_action :set_assigned_users, only: [ :new, :edit, :create, :update ]

  def index
    @tasks = current_user.admin? ? Task.all : Task.visible_to(current_user)
  end

  def show
    # @task is already set by the set_task before_action
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    calculate_time_spent

    if @task.save
      redirect_to tasks_path, notice: "Task was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @task is already set by the set_task before_action
  end

  def update
    calculate_time_spent

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
    @task = if current_user.admin?
              Task.find(params[:id])
            else
              Task.visible_to(current_user).find_by(id: params[:id])
            end

    unless @task
      flash[:error] = "You are not authorized to access this task."
      redirect_to tasks_path
    end
  end

  def set_active_projects
    @active_projects = if current_user.admin?
                         Project.where(active: true, archived: false)
                       else
                         current_user.projects.where(active: true, archived: false)
                       end
  end

  def set_assigned_users
    project_id = params.dig(:task, :project_id)&.to_i || @task&.project_id
    Rails.logger.debug params.inspect

    if project_id.present?
      @assigned_users = Project.find_by(id: project_id)&.users || []
    else
      @assigned_users = []
    end
  end


  def calculate_time_spent
    if @task.started_at.present? && @task.end_time.present?
      @task.time_spent = ((@task.end_time - @task.started_at) / 1.hour).round
    end
  end

  def task_params
    params.require(:task).permit(:title, :task_type, :project_id, :description, :time_spent, :deadline, :started_at, :assigned_user_id, :end_time)
  end
end
