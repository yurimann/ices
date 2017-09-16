class CreateSales < ActiveRecord::Migration[5.0]
  def change
    create_table :sales do |t|
      t.float :cash
      t.float :online
      t.float :credit_card
      t.float :skip_the_dishes

      t.timestamps
    end
  end
end
