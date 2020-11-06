class TasksController < ApplicationController
  def new
    @task = Task.new
  end
  def create
    Task.create(name: params[:task][:name], content: params[:task][:content])
    redirect_to new_task_path
  end
end
