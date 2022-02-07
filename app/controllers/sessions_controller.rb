class SessionsController < ApplicationController
  def create
    if User.exists?(username: session_params[:username])
      authenticate_user(session_params)
    else
      create_user(session_params)
    end
  end

  def destroy
    session[:user_id] = nil
    render json: {}, status: :gone
  end

  private

  def session_params
    params.require(:session).permit(:username, :password, :password_confirmation, :email, :timezone)
  end

  def create_user(user_params)
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def authenticate_user(session_params)
    @user = User.find_by(username: session_params[:username])
    if @user&.authenticate(session_params[:password])
      session[:user_id] = @user.id
      render json: @user, status: :accepted
    else
      render json: {}, status: :unauthorized
    end
  end
end
