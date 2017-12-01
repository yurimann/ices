class ExpensesController < ApplicationController
  def index
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)

    if @expense.save
      flash[:notice] = "Successfully recorded expense"
      redirect_to root_path
    else
      flash[:alert] = "Warning Batman! Warning! Expense not saved"
      render new_expense_path
    end
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def update
    @expense = Expense.find(params[:id])
    if @expense.update(expense_params)
      flash[:notice] = "Successfully updated expense"
      redirect_to root_path
    else
      flash[:alert] = "Warning Batman! Warning! Expense not updated"
      render edit_expense_path
    end

  end

  def destroy
    @expense = Expense.find(params[:id])
    if @expense.destroy
      flash[:notice] = "Successfully deleted expense"
      redirect_to root_path
    else
      flash[:alert] = "Warning Batman! Warning! Expense not deleted"
      render expenses_range_path
    end

  end

  def range

    month = helpers.date_formatter(params[:from][:month])
    day = helpers.date_formatter(params[:from][:day])
    @from = "#{params[:from][:year]}-#{month}-#{day}"

    to_month = helpers.date_formatter(params[:to][:month])
    to_day = helpers.date_formatter(params[:to][:day])
    @to = "#{params[:to][:year]}-#{to_month}-#{to_day}"

    @expenses = Expense.expense_range(@from, @to)

    respond_to do |format|
      format.html
      format.json { render json: @expenses }
    end

  end

  def import_from_drive
    respond_to do |format|
      format.html
      format.json { render json: "Done" }
    end
    File.read('config/initializers/config.json')
    session = GoogleDrive::Session.from_config("config.json")
    byebug
    session.spreadsheets.each do |sheet|
      if (sheet.title.downcase.include? "expenses") && (sheet.title.downcase.include? params[:month]) && (sheet.title.downcase.include? params[:year])

        page = sheet.worksheets[0]
        x = 3
        until x >= (sheet.worksheets[0].rows.length) do

          date = page[x, 1].to_date
          expense_type = page[x,2]
          notes = page[x,4]

          amount = page[x,3]
          amount = amount.split(//)
          amount.delete(",")
          amount.shift
          amount = amount.join.to_f

          unless amount <= 0
            Expense.create(date: date, expense_type: expense_type, amount: amount , notes: notes)
          end
          x += 1
        end
      end
    end
      # redirect_back_or_to expenses_path
  end

  private
  def expense_params
    params.require(:expense).permit(:date, :expense_type, :amount, :notes)
  end
end
