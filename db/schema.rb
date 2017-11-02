# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171009034201) do

  create_table "details", force: :cascade do |t|
    t.integer  "recipe_id"
    t.integer  "ingredient_id"
    t.integer  "quantity"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "unit"
  end

  create_table "expenses", force: :cascade do |t|
    t.string   "expense_type"
    t.date     "date"
    t.float    "amount"
    t.string   "notes"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "ingredients", force: :cascade do |t|
    t.string   "name"
    t.float    "package_quantity"
    t.float    "cost"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "unit"
  end

  create_table "recipes", force: :cascade do |t|
    t.string   "name"
    t.integer  "serving_size"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "sales", force: :cascade do |t|
    t.float    "amount"
    t.string   "sale_type"
    t.date     "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
