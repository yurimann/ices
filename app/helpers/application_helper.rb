module ApplicationHelper
  def ingredients_for_select
    Ingredient.all.collect { |i| [i.name, i.id]}
  end
end
