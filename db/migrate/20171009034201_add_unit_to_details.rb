class AddUnitToDetails < ActiveRecord::Migration[5.0]
  def change
    add_column :details, :unit, :string
  end
end
