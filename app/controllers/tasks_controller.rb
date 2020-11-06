class TasksController < ApplicationController
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
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
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
end
