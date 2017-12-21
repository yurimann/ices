class ProfitsController < ApplicationController
  def index
  end

  def month
    @month = parse_number
    @year = params[:date][:year]
    range = (@month + @year).to_date

    sales = Sale.where("date >= ? AND date <= ?", range.beginning_of_month, range.end_of_month)
    expenses = Expense.where("date >= ? AND date <= ?", range.beginning_of_month, range.end_of_month)
    weekly_sales = sales.group_by_day_of_week(:date).sum(:amount)
    weekly_expenses = expenses.group_by_day_of_week(:date).sum(:amount)

    @weekly_profits = {}
    day = {"0": "Sunday", "1": "Monday", "2": "Tuesday", "3": "Wednesday", "4": "Thursday", "5": "Friday", "6": "Saturday"}
    x = 0

    until x >= weekly_sales.length do
      date = x.to_s.to_sym
      @weekly_profits[day[date]] = weekly_sales[x] - weekly_expenses[x]
      x += 1
    end

    @sales_totals = add_up(sales)
    @expense_totals = add_up(expenses)
    @profits = @sales_totals - @expense_totals
  end

  def year
    @year = params[:date][:year]

    year_start = ("January" + @year.to_s).to_date.beginning_of_year
    year_end = year_start.end_of_year
    sales = Sale.where("date >= ? AND date <= ?", year_start, year_end).order(:date)
    expenses = Expense.where("date >= ? AND date <= ?", year_start, year_end).order(:date)

    month = {"0": "january", "1": "february", "2": "march", "3": "april", "4": "may", "5": "june", "6": "july", "7": "august", "8": "september", "9": "october", "10": "november", "11": "december"}
    monthly_sales = sales.group_by_month(:date, format: "%B").sum(:amount)
    monthly_expenses = expenses.group_by_month(:date, format: "%B").sum(:amount)
    @monthly_profits = {}

    x = 0

    until x >= month.length do
      date = x.to_s.to_sym
      if monthly_sales[month[date].capitalize] != nil && monthly_expenses[month[date].capitalize] != nil
        @monthly_profits[month[date].capitalize] = monthly_sales[month[date].capitalize] - monthly_expenses[month[date].capitalize]
      end
      x += 1
    end

    @sales_totals = add_up(sales)
    @expense_totals = add_up(expenses)
    @profits = @sales_totals - @expense_totals
  end
end
