class SummaryController < ApplicationController

  def index
    @sales = Sale.all
    @expenses = Expense.all
    Expense.import_file
  end

  def write_to_excel
    from = params[:from]
    to = params[:to]
    export_data = Sale.where("date >= ? and date <= ?", from, to).order(:date)
    pd = Dir.home() + "/swirls"
    if !Dir.exist?(pd)
      Dir.mkdir(File.join(Dir.home, "swirls"), 0700)
    end
    workbook = WriteExcel.new("#{pd}/report.xls")
    worksheet = workbook.add_worksheet
    x = 0
    until x == 3 do
      headers = ["Amount", "Sale Type", "Date"]
      worksheet.write(0, x, headers[x])
      x += 1
    end

    y = 1
    z = 0
    until y > export_data.length do
      worksheet.write(y, 0, export_data[z].amount)
      worksheet.write(y, 1, export_data[z].sale_type)
      worksheet.write(y, 2, export_data[z].date)
      y += 1
      z += 1
    end
    workbook.close
  end


    def write_expenses
      from = params[:from]
      to = params[:to]
      export_data = Expense.where("date >= ? and date <= ?", from, to).order(:date)
      pd = Dir.home() + "/swirls"
      if !Dir.exist?(pd)
        Dir.mkdir(File.join(Dir.home, "swirls"), 0700)
      end
      workbook = WriteExcel.new("#{pd}/expense_report.xls")
      worksheet = workbook.add_worksheet
      x = 0
      until x > 3 do
        headers = ["date", "expense_type", "notes", "amount"]
        worksheet.write(0, x, headers[x])
        x += 1
      end

      y = 1
      z = 0
      total = 0
      until y > export_data.length do
        total += export_data[z].amount
        worksheet.write(y, 0, export_data[z].date)
        worksheet.write(y, 1, export_data[z].expense_type)
        worksheet.write(y, 2, export_data[z].notes)
        worksheet.write(y, 3, export_data[z].amount)
        y += 1
        z += 1
      end
      worksheet.write(export_data.length + 1, 2, "Total Expenses")
      worksheet.write(export_data.length + 1, 3, total)
      workbook.close
    end
end
