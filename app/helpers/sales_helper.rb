module SalesHelper
  def date_formatter(check)
    minimum_date = 10
    if check.to_i < minimum_date
      check = "0#{check}"
    end
    check
  end
end
