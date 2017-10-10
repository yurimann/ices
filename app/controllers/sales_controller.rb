class SalesController < ApplicationController
  def index
    @sales = Sale.all
    test = Date.today
  end

  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new(sales_params)

    if @sale.duplicate_checker == nil
      if @sale.save
        flash[:notice] = "Successfully saved"
        redirect_to root_path
      else
        flash[:alert] = "Something went wrong"
        render new_sale_path
      end
    else
      flash[:alert] = "Duplicate Entry"
      render new_sale_path
    end

  end

  def edit
  end

  def update
  end

  def delete
  end

  def range
    month = helpers.date_formatter(params[:from][:month])
    day = helpers.date_formatter(params[:from][:day])
    from = "#{params[:from][:year]}-#{month}-#{day}"

    to_month = helpers.date_formatter(params[:to][:month])
    to_day = helpers.date_formatter(params[:to][:day])
    to = "#{params[:to][:year]}-#{to_month}-#{to_day}"
    byebug
    @sales = Sale.sale_range(from, to)
  end

  private

  def sales_params
    params.require(:sale).permit(:date, :amount, :sale_type)
  end


end
