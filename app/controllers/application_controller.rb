class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  before_filter :require_login

  def import_from_drive
    File.read('config/initializers/config.json')
    session = GoogleDrive::Session.from_config("config.json")

    session.spreadsheets.each do |sheet|
      if sheet.title.downcase.include? "expenses"
        array_length = sheet.worksheets[0].rows.length
        page = sheet.worksheets[0]
        x = 3
        until x >= array_length - 2 do

          date = page[x, 1].to_date
          expense_type = page[x,2]
          notes = page[x,4]

          amount = page[x,3]
          amount = amount.split(//)
          amount.shift
          amount = amount.join.to_f
          unless amount <= 0
            Expense.create(date: date, expense_type: expense_type, amount: amount , notes: notes)
          end
          x += 1
        end
      end
    end
  end

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
