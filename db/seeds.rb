# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do
  Sale.create(date: Faker::Date.between(10.days.ago, Date.today), sale_type: "Cash", amount: Faker::Number.decimal(3, 3) )
  Sale.create(date: Faker::Date.between(20.days.ago, Date.today), sale_type: "Online", amount: Faker::Number.decimal(3, 3) )
  Sale.create(date: Faker::Date.between(20.days.ago, Date.today), sale_type: "Credit Card", amount: Faker::Number.decimal(3, 3) )
  Sale.create(date: Faker::Date.between(15.days.ago, Date.today), sale_type: "Skip The Dishes", amount: Faker::Number.decimal(3, 3) )

  x = ["Ingredients", "Salary", "Cake Supplies", "Packaging", "Fuel", "Miscellaneous"]

  Expense.create(expense_type: x[rand(5)] , date: Faker::Date.between(20.days.ago, Date.today), amount: Faker::Number.decimal(2, 3), notes: Faker::RuPaul.quote)
end

15.times do
  choice = ['g', 'ml', 'oz', 'lb', 'piece']
  x = rand(3)
  Ingredient.create(name: Faker::Food.ingredient, package_quantity: rand(2000..5000), unit: choice[x], cost: rand(2.99..10.99))

  5.times do
    Detail.create(recipe_id: rand(1..10), ingredient_id: rand(1..15), unit: choice[x], quantity: rand(10..150))
  end

end

10.times do
  x = "#{Faker::Food.dish} cupcake"
  Recipe.create(name: x, serving_size: rand(50..75), selling_price: 2.59)
end
