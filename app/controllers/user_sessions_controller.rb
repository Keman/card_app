class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    if @user = login(user_sessions_params[:email], user_sessions_params[:password])
      flash[:success] = "Привет!"
      redirect_back_or_to user_path(@user)
    else
      flash.now[:danger] = "Ошибка входа"
      render action: "new"
    end
  end

  def destroy
    logout
    flash[:success] = "До встречи!"
    redirect_to root_path
  end

  private

  def user_sessions_params
    params.require(:user_sessions).permit(:email, :password)
  end
end
