module RecipesHelper
  def calculate_unit_cost(recipe_id)
    recipe = Recipe.find(recipe_id)
    details = recipe.details
    subtotal = 0
    details.each do |detail|
      ingredient = Ingredient.find(detail.ingredient_id)
      subtotal += (detail.quantity * ingredient.cost)/ingredient.package_quantity
    end
    subtotal = subtotal/recipe.serving_size
  end
end
