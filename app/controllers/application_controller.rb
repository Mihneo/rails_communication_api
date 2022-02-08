class ApplicationController < ActionController::API
  before_action :logged_in?, except: %i[current_user authorized]

  def logged_in?
    render json: {}, status: :unauthorized unless session[:user_id].present?
  end

  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  def authorized
    render json: {}, status: :unauthorized unless current_user
  end
end
