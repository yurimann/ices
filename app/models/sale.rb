class Sale < ApplicationRecord

  def self.sale_range(month_start, month_end)
    Sale.where("date >= ? and date <= ?", month_start, month_end)
  end

end
