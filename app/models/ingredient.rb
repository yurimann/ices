class Ingredient < ApplicationRecord
  has_many :details
  has_many :recipes, through: :details

  def convert
    gram = 453.592
    ml = 29.5735
    if self.unit == "lb"
      self.package_quantity *= gram
      self.unit = "g"
    end
    if self.unit == "oz"
      self.package_quantity *= ml
      self.unit = "ml"
    end
    self.save
  end
end
