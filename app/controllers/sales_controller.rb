class SalesController < ApplicationController
  def index
    @sales = Sale.all
  end

  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new(sales_params)
    if @sale.save
      flash[:notice] = "Successfully saved"
      redirect_to root_path
    else
      flash[:alert] = "Something went wrong"
      render new_sale_path
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  private

  def sales_params
    params.require(:sale).permit(:date, :amount, :sale_type)
  end
end
