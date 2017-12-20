class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  before_action :require_login

  def current_user
    if session[:user_id]
      unless User.where(id: session[:user_id]).empty?
        @current_user ||= User.find(session[:user_id])
      end
    end
  end

  helper_method :current_user

  def parse_number
    if params[:month] != nil
      month_selected = params[:month].to_sym
    elsif params[:date][:month] != nil
      month_selected = params[:date][:month].to_sym
    else
      return nil
    end
    month = {"1": "january", "2": "february", "3": "march", "4": "april", "5": "may", "6": "june", "7": "july", "8": "august", "9": "september", "10": "october", "11": "november", "12": "december"}
    month[month_selected]
  end

  def add_up(value)
    total = 0
    value.each do |val|
      total += val.amount
    end
    total
  end

  private

  def require_login
    unless current_user
      redirect_to log_in_path
    end
  end
end
