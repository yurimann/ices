class IngredientsController < ApplicationController

  def index
    @ingredients = Ingredient.all
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    @ingredient.convert
    if @ingredient.save
      flash[:notice] = "Successfully saved"
      redirect_to ingredients_path
    else
      flash[:alert] = "Something went wrong. Try again"
      render new_ingredient_path
    end
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    @ingredient.convert
    if @ingredient.update(ingredient_params)
      flash[:notice] = "Successfully updated"
      redirect_to ingredients_path
    else
      flash[:alert] = "Something went wrong. Try again"
      render edit_ingredient_path
    end
  end

  def destroy
    @ingredient = Ingredient.find(params[:id])
    if @ingredient.destroy
      flash[:notice] = "Successfully deleted"
      redirect_to ingredients_path
    else
      flash[:alert] = "Something went wrong. Try again"
      render edit_ingredient_path
    end
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :package_quantity, :cost, :unit)
  end
end
