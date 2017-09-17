class IngredientsController < ApplicationController
  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      flash[:notice] = "Successfully saved"
      redirect_to root_path
    else
      flash[:alert] = "Something went wrong. Try again"
      render new_ingredient_path
    end
  end

  def update
  end

  def edit
  end

  def delete
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :package_quantity, :cost)
  end
end
