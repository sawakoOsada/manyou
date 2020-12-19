class Admin::UsersController < ApplicationController
  before_action :require_admin_user
  before_action :set_user, only: [:edit, :update, :destroy, :show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if User.where(email: @user.email).count >= 1
      flash[:notice] = '既に登録されているメールアドレスです'
      render :new
    elsif @user.save
      redirect_to admin_users_path, notice: 'ユーザーを作成しました'
    else
      render :new
    end
  end

  def index
    @users = User.select(:id, :name, :created_at, :admin).order(created_at: :desc)
  end

  def show
    @tasks = @user.tasks
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "ユーザーを編集しました"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice:'ユーザーを削除しました'
  end

  private
  def require_admin_user
    unless current_user.admin?
      redirect_to(root_url)
      flash[:notice] = '権限のないユーザーです'
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name,
                                 :email,
                                 :password,
                                 :password_confirmation,
                                 :admin)
  end
end
