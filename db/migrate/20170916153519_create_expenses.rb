class CreateExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :expenses do |t|
      t.string :type
      t.date :date
      t.float :amount
      t.string :notes

      t.timestamps
    end
  end
end
