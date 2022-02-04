class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: params[:username])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      render json: @user, status: :accepted, location: @user
    else
      render json: @user, status: :unauthorized, location: @user
    end
  end

  def destroy
    session[:user_id] = nil
    render json: @user, status: :gone, location: @user
  end
end