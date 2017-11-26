class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
    ingredients = Ingredient.all
    ingredients.each { |ingredient| helpers.convert(ingredient)}
    @top_ten = {}

    @recipes.each do |recipe|
      unit_cost = helpers.calculate_unit_cost(recipe.id)
      @top_ten[recipe.name] = unit_cost
    end

    @top_ten = @top_ten.sort_by {|k,v| v}.reverse.to_h
    @top_ten = @top_ten.first(10).to_h
  end

  def show
    @recipe = Recipe.find(params[:id])
    @details = @recipe.details
  end

  def new
    @ingredients = Ingredient.all
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @ingredients = Ingredient.all
    @detail = Detail.new

    if @recipe.save
      flash[:notice] = "Yeah! New recipe!"
      redirect_to root_path
    else
      flash[:alert] = "Error Will Robinson, error!"
      render new_recipe_path
    end

  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    byebug
    if @recipe.update(recipe_params)
      flash[:notice] = "Yeah! Recipe edited!"
      redirect_to root_path
    else
      flash[:alert] = "Error Will Robinson, error!"
      render new_recipe_path
    end
  end

  def destroy
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name,:selling_price, :serving_size, details_attributes: [:quantity, :ingredient_id, :recipe_id, :unit, :id, :_destroy])
  end

end
