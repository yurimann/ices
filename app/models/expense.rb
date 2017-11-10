class Expense < ApplicationRecord
  def self.expense_range(month_start, month_end)
    result = Expense.where("date >= ? and date <= ?", month_start, month_end).order(:date)
    return result
  end

  def date_formatter
    minimum_date = 10
    new_date = self
    if self.to_i < minimum_date
      new_date = "0#{self}"
    end
    new_date
  end

  def duplicate_checker
    x = false
    if Sale.where("date == ? and sale_type == ?", self.date, self.sale_type).any?
      x = true
    end
  end

  def self.import_file
    book = Spreadsheet.open("expense_report.xls")
    row = book.worksheet('Sheet1')

    x = 1
    result = []
    until row[x,0].nil? do
      y = 0
      until row[x,y].nil? do
        pair = {}
        pair[row[0,y].downcase] = row[x,y]
        result << pair
        y += 1
      end
    a = 0
    until a >= result.length - 1 do
      temp = result[0].merge(result[a + 1])
      result[0] = temp
      a += 1
    end
      Expense.create(temp)
      x += 1
    end
  end
end
