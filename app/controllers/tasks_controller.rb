class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle_state]
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, notice:'作成しました'
    else
      render :new
    end
  end

  def index
    if params[:sort_expired]
      @tasks = Task.all.order('deadline DESC')
    elsif params[:search]
      @tasks = Task.where(['name LIKE ?', "%#{params[:search]}%"])
    else
      @tasks = Task.all.order('created_at DESC')
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice:'編集しました'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:'削除しました'
  end

  private
  def task_params
    params.require(:task).permit(:name, :content, :deadline, :state)
  end

  def set_task
    @task = Task.find(params[:id] || params[:task_id])
  end
end
