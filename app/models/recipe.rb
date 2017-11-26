class Recipe < ApplicationRecord
  has_many :details
  has_many :ingredients, through: :details
  accepts_nested_attributes_for :details, reject_if: :all_blank, allow_destroy: :true


  def self.find_ten

  end

end
