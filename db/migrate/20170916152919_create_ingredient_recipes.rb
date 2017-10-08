class CreateIngredientRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :details do |t|
      t.integer :recipe_id
      t.integer :ingredient_id
      t.integer :quantity

      t.timestamps
    end
  end
end
