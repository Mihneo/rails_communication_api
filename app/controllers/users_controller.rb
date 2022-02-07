class UsersController < ApplicationController
  def index
    @users = User.all

    render json: @users
  end

  def show
    if User.exists?(id: params[:id])
      render json: user
    else
      render json: {}, status: :not_found
    end
  end

  def create
    if logged_in?
      render json: {}, status: :forbidden
    else
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        render json: @user, status: :created, location: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    user
  end

  private

  def user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email, :timezone)
  end
end
