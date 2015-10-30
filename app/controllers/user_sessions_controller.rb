class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    if @user = login(user_sessions_params[:email], user_sessions_params[:password])
      flash[:success] = t "user_session.create.success"
      redirect_back_or_to root_path
    else
      flash[:danger] = t "user_session.create.danger"
      redirect_to :back
    end
  end

  def destroy
    logout
    flash[:success] = t "user_session.destroy"
    redirect_to root_path
  end

  private

  def user_sessions_params
    params.require(:user_sessions).permit(:email, :password)
  end
end
