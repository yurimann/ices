module ApplicationHelper
  def ingredients_for_select
    Ingredient.all.collect { |i| [i.name, i.id]}
  end

  def ingredient_unit
    x = []
    Ingredient.all.map do |i|
      if !x.include? i
         x << i.unit
       end
    end
    x
  end
end
