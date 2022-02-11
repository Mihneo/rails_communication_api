class ApplicationController < ActionController::API
  before_action :logged_in?
  serialization_scope :current_user

  def logged_in?
    render json: {}, status: :unauthorized unless session[:user_id].present?
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id].present?
  end

  def authorized
    render json: {}, status: :unauthorized unless current_user
  end
end
