class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: session_params[:username])
    if @user&.authenticate(session_params[:password])
      session[:user_id] = @user.id
      render json: @user, status: :accepted
    else
      render json: {}, status: :unauthorized
    end
  end

  def destroy
    session[:user_id] = nil
    render json: @user, status: :gone, location: @user
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end
end