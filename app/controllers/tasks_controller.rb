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
    @tasks = Task.select(:id, :name, :content, :deadline, :state, :priority, :created_at).order('created_at DESC')
    if params[:sort_expired]
      @tasks = current_user.tasks.order('deadline ASC')
    elsif params[:sort_prioritized]
      @tasks = current_user.tasks.order('priority DESC')
    elsif params[:name].present? && params[:state].present?
      @tasks = @tasks.search_name("%#{params[:name]}%").search_state(params[:state])
    elsif params[:name].present?
      @tasks = @tasks.search_name("%#{params[:name]}%")
    elsif params[:state].present?
      @tasks = @tasks.search_state(params[:state])
    elsif params[:label]
      @tasks = @tasks.joins(:labels).where(labels: { id: params[:label] })
    else
      @tasks = Task.select(:id, :name, :content, :deadline, :state, :priority, :created_at).order('created_at DESC')
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
    params.require(:task).permit(:name, :content, :deadline, :state, :priority, label_ids: [] )
  end

  def set_task
    @task = Task.find(params[:id] || params[:task_id])
  end

end
