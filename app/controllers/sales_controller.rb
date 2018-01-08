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

    @month = parse_number
    if params[:year] != nil
      @year = params[:year]
    elsif params[:date][:year] != nil
      @year = params[:date][:year]
    else
      @year = Date.today.year.to_s
    end
    if @month != nil
      range = (@month + @year).to_date
      @sales = Sale.where("date >= ? AND date <= ?", range.beginning_of_month, range.end_of_month)
    else
      year_start = ("January" + @year.to_s).to_date.beginning_of_year
      year_end = year_start.end_of_year
      @sales = Sale.where("date >= ? AND date <= ?", year_start, year_end).order(:date)
    end

    respond_to do |format|
      format.html
      format.json { render json: @sales }
    end

  end

  def import_sales_from_drive
    month = parse_number
    if params[:year] == nil
      year = params[:date][:year]
    else
      year = params[:year]
    end

    File.read('config/initializers/config.json')
    session = GoogleDrive::Session.from_config("config.json")

    session.spreadsheets.each do |sheet|

      if (sheet.title.downcase.include? "sales") && (sheet.title.downcase.include? month) && (sheet.title.downcase.include? year)

        page = sheet.worksheets[0]
        x = 3

        until (page.rows[x,1] == nil && page.rows[x + 1,1] == nil) do
          if page[x,1] == ""
            x += 1
          end
          if page[x, 1] != ""
            date = (page[x, 1] + "," + params[:year]).to_date
          else
            date = ""
          end
          amount_field = 2
          sales_columns = 6

          until amount_field > 6 do
            amount = page[x, amount_field]

            if amount.to_f > 0
              amount = amount.split(//)
              amount.delete(",")
              if amount[0] == "$"
                amount.shift
              end
              amount = amount.join.to_f
              sales_type = page[2, amount_field].capitalize
            end

          unless amount.to_f <= 0 || date == ""
            sale = Sale.new(date: date, sale_type: sales_type, amount: amount)
            unless Sale.exists?(date: date, sale_type: sales_type, amount: amount)
              sale.save
            end
          end
          amount_field += 1
        end

          x += 1
        end
      end
    end
    @sale = Sale.last
    respond_to do |format|
      format.html
      format.json { render json: @sale}
    end
  end

  private

  def sales_params
    params.require(:sale).permit(:date, :amount, :sale_type)
  end

end
