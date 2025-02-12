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
      redirect_to tasks_path, notice: 'タスクが作成されました。'
    else
      @tasks = current_user.tasks.includes(:user).order(updated_at: :desc)
      flash.now[:alert] = 'タスクの作成に失敗しました。'
      render :index, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'タスクが更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'タスクが削除されました。'
  end

  def update_status
    if @task.update(status: params[:status])
      redirect_to tasks_path, notice: 'タスクの状態が更新されました。'
    else
      redirect_to tasks_path, alert: 'タスクの状態の更新に失敗しました。'
    end
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :due_date, :parent_task_id)
  end
end 