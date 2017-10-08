class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def new
    @ingredients = Ingredient.all
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @ingredients = Ingredient.all
    @detail = Detail.new
    byebug
    if @recipe.save
      flash[:notice] = "Yeah! New recipe!"
      redirect_to root_path
    else
      flash[:alert] = "Error Will Robinson, error!"
      render new_recipe_path
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :serving_size, details_attributes: [:quantity, :ingredient_id, :recipe_id, :_destroy])
  end

end
