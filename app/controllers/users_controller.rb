class UsersController < ApplicationController
  def new
    if logged_in?
      redirect_to tasks_path, notice:'既にログインしています'
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks
    if current_user != @user
      redirect_to tasks_path, notice:'権限のないユーザーです'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
