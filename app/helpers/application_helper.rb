module ApplicationHelper
  require 'pathname'
  def date_formatter(check)
    minimum_date = 10
    if check.to_i < minimum_date
      check = "0#{check}"
    end
    check
  end

  def write_to_excel(export_data)
    pd = Dir.home() + "/sales"
    if !Dir.exist?(pd)
      Dir.mkdir(File.join(Dir.home, "sales"), 0700)
    end
    workbook = WriteExcel.new("#{pd}/sales.xls")
    worksheet = workbook.add_worksheet
    x = 0
    until x == 3 do
      headers = ["Amount", "Sale Type", "Date"]
      worksheet.write(0, x, headers[x])
      x += 1
    end

    y = 0
    z = 0
    until y>= export_data.length do
      worksheet.write(y, 1, export_data[z].amount)
      worksheet.write(y, 2, export_data[z].sale_type)
      worksheet.write(y, 3, export_data[z].date)
      y += 1
      z += 1
    end
    workbook.close
  end

  def convert(ingredient)
    gram = 453.592
    ml = 29.5735
    if ingredient.unit == "lb"
      ingredient.package_quantity *= gram
      ingredient.unit = "g"
    end
    if ingredient.unit == "oz"
      ingredient.package_quantity *= ml
      ingredient.unit = "ml"
    end
    ingredient.save
  end
end
