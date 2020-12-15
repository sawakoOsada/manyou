class UsersController < ApplicationController
  def new
    if current_user.admin? || !logged_in?
      @user = User.new
    else
      redirect_to tasks_path, notice:'既にログインしています'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      if current_user.admin?
        redirect_to admin_users_path, notice: "ユーザーを作成しました"
      else
        log_in @user
        redirect_to @user
      end
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks
    if current_user != @user
      redirect_to tasks_path, notice:'権限のないユーザーです' unless current_user.admin?
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
