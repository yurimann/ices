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
      format.csv do
        response.headers['Content-Type'] = 'text/csv'
        response.headers['Content-Disposition'] = 'attachment; filename=sales.csv'
      end
      format.json { render json: @sales }
    end

  end

  private
  def expense_params
    params.require(:expense).permit(:date, :expense_type, :amount, :notes)
  end
end
