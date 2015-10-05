class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :find_user, :user_check, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(params[:user][:email], params[:user][:password])
      flash[:success] = "Добро пожаловать!"
      redirect_to root_path
    else
      render "new"
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Успешно изменено"
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def user_check
    if @user.id != current_user.id
      flash[:warning] = "Неверный пользователь"
      redirect_back_or_to root_path
    end
  end
end
