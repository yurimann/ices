class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  before_filter :require_login

  def current_user
    if session[:user_id]
      unless User.where(id: session[:user_id]).empty?
        @current_user ||= User.find(session[:user_id])
      end
    end
  end

  helper_method :current_user

  private

  def require_login
    unless current_user
      redirect_to log_in_path
    end
  end
end
