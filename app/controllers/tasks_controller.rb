class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update]
  def new
    @task = Task.new
  end

  def create
    Task.create(task_params)
    redirect_to new_task_path
  end

  def index
    @tasks = Task.all
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path
    else
      render :edit
    end
  end

  private
  def task_params
    params.require(:task).permit(:name, :content)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
