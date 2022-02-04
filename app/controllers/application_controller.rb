class ApplicationController < ActionController::API

  def logged_in?
    !session[:user_id].nil?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if logged_in?
  end

  def authorized
    render json: {}, status: :unauthorized unless current_user
  end
end
