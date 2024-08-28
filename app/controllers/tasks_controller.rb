class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :authorize_admin!, only: %i[index]
  before_action :authorize_user!, only: %i[create new edit update]

  def index
    @tasks = current_user.admin? ? Task.all : Task.where(user: current_user)
  end

  def show
  end

  def new
    @task = Task.new
    # Authorization check is redundant here since anyone can create a new task
    # and it is handled during the create action
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def edit
    @task
    authorize_user!
  end

  def update
    # Only allow updating if the current user is an admin or the owner of the task
    authorize_user!
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    # Only allow destroying if the current user is an admin or the owner of the task
    authorize_user!
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :time_spent, :deadline, :started_at, :ended_at, :task_type, :project_id, :user_id)
  end

  def authorize_admin!
    redirect_to(root_path, alert: 'Access denied.') unless current_user.admin?
  end

  def authorize_user!
    return if current_user.admin? || (current_user == @task&.user)

    redirect_to(root_path, alert: 'Access denied.')
  end
end
