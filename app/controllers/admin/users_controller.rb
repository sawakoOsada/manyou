class Admin::UsersController < ApplicationController
  before_action :admin_user
  before_action :set_user, only: [:edit, :update, :destroy]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "ユーザーを作成しました"
    else
      render :new
    end
  end

  def index
    @users = User.all.order(created_at: :desc)
  end

  def edit
  end

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
  def admin_user
    unless current_user.admin?
      redirect_to(root_url)
      flash[:notice] = '権限のないユーザーです'
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
