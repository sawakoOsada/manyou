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

  private
  def task_params
    params.require(:task).permit(:name, :content)
  end
end