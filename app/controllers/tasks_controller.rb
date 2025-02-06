class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :update_status]

  def index
    @tasks = current_user.tasks.includes(:user).order(updated_at: :desc)
  end

  def show
    @subtasks = @task.subtasks.includes(:user)
  end

  def new
    @task = current_user.tasks.build
    @task.parent_task_id = params[:parent_task_id]
  end

  def edit
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully deleted.'
  end

  def update_status
    if @task.update(status: params[:status])
      redirect_to tasks_path, notice: 'Task status updated.'
    else
      redirect_to tasks_path, alert: 'Failed to update task status.'
    end
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :status, :parent_task_id)
  end
end 