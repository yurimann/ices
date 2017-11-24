class AddSellingPriceToRecipes < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :selling_price, :float
  end
end
