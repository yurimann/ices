class Sale < ApplicationRecord

  def self.sale_range(month_start, month_end)
    result = Sale.where("date >= ? and date <= ?", month_start, month_end).order(:date)
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

end
