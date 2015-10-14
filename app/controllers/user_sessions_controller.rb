class UserSessionsController < ApplicationController
  skip_before_action :require_login, :verify_authenticity_token, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    if @user = login(user_sessions_params[:email], user_sessions_params[:password])
      flash[:success] = "Привет!"
      redirect_back_or_to root_path
    else
      flash[:danger] = "Ошибка входа"
      redirect_to :back
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
