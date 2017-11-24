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
    @sale = Sale.find(params[:id])
  end

  def update
    @sale = Sale.find(params[:id])

    if @sale.update(sales_params)
      flash[:notice] = "Successfully updated"
      redirect_to root_path
    else
      flash[:alert] = "Something went wrong"
      render edit_sale_path
    end
  end

  def destroy
    @sale = Sale.find(params[:id])
    if @sale.destroy
      flash[:notice] = "Successfully deleted sale"
      redirect_to root_path
    else
      flash[:alert] = "Warning Batman! Warning! Sale not deleted"
      render sales_range_path
    end
  end

  def range

    month = helpers.date_formatter(params[:from][:month])
    day = helpers.date_formatter(params[:from][:day])
    @from = "#{params[:from][:year]}-#{month}-#{day}"

    to_month = helpers.date_formatter(params[:to][:month])
    to_day = helpers.date_formatter(params[:to][:day])
    @to = "#{params[:to][:year]}-#{to_month}-#{to_day}"

    @sales = Sale.sale_range(@from, @to)

    respond_to do |format|
      format.html
      format.json { render json: @sales }
    end

  end

  private

  def sales_params
    params.require(:sale).permit(:date, :amount, :sale_type)
  end

end
