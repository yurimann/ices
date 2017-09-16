class Sale < ApplicationRecord
  accepts_nested_attributes_for :cash
  accepts_nested_attributes_for :online
  accepts_nested_attributes_for :credit_card
  accepts_nested_attributes_for :skip_the_dishes
end
