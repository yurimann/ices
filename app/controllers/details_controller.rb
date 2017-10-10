class DetailsController < ApplicationController
  def index
  end

  def new
    @detail = Detail.new
  end

  def create
    @detail = Detail.new(detail_params)
  end

  def edit
  end

  def update
  end

  def delete
  end

  private

  def detail_params
    params.require(:detail).permit(:recipe_id, :ingredient_id, :quantity, :unit)
  end
end
