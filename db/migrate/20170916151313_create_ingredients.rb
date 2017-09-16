class CreateIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.integer :package_quantity
      t.float :cost

      t.timestamps
    end
  end
end
