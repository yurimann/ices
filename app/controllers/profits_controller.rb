class ProfitsController < ApplicationController
  def index
  end

  def month
    @month = parse_number
    @year = params[:date][:year]
    range = (@month + @year).to_date
    sales = Sale.where("date >= ? AND date <= ?", range.beginning_of_month, range.end_of_month)
    expenses = Expense.where("date >= ? AND date <= ?", range.beginning_of_month, range.end_of_month)
    @sales_totals = add_up(sales)
    @expense_totals = add_up(expenses)
    @profits = @sales_totals - @expense_totals
  end

  def year
    @year = params[:date][:year]
    sales = Sale.where("cast(strftime('%Y', date) as int) = ?", @year)
    expenses = Expense.where("cast(strftime('%Y', date) as int) = ?", @year)
    @sales_totals = add_up(sales)
    @expense_totals = add_up(expenses)
    @profits = @sales_totals - @expense_totals
  end
end
