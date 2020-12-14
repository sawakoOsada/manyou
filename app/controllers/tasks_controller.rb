class TasksController < ApplicationController
  before_action :authenticate_user
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id

    if @task.save
      redirect_to tasks_path, notice:'作成しました'
    else
      render :new
    end
  end

  def index
    @tasks = current_user.tasks.all.order('created_at DESC')
    if params[:sort_expired]
      @tasks = Task.all.order('deadline ASC')
    elsif params[:sort_prioritized]
      @tasks = Task.all.order('priority DESC')
    elsif params[:name].present? && params[:state].present?
      @tasks = Task.search_name("%#{params[:name]}%").search_state(params[:state])
    elsif params[:name].present?
      @tasks = Task.search_name("%#{params[:name]}%")
    elsif params[:state].present?
      @tasks = Task.search_state(params[:state])
    else
      @tasks = @tasks.all.order('created_at DESC')
    end
    @tasks = @tasks.page(params[:page])
  end

  def show; end

  def edit; end

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
    params.require(:task).permit(:name, :content, :deadline, :state, :priority)
  end

  def set_task
    @task = Task.find(params[:id] || params[:task_id])
  end

end
