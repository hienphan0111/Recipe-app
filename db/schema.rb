# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_05_29_135726) do
  create_table "foods", force: :cascade do |t|
    t.string "name"
    t.integer "measurement_unit"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "users_id"
    t.index ["users_id"], name: "index_inventories_on_users_id"
  end

  create_table "inventory_foods", force: :cascade do |t|
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "inventories_id"
    t.integer "foods_id"
    t.index ["foods_id"], name: "index_inventory_foods_on_foods_id"
    t.index ["inventories_id"], name: "index_inventory_foods_on_inventories_id"
  end

  create_table "recipe_foods", force: :cascade do |t|
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "recipes_id"
    t.integer "foods_id"
    t.index ["foods_id"], name: "index_recipe_foods_on_foods_id"
    t.index ["recipes_id"], name: "index_recipe_foods_on_recipes_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.integer "preparation_time"
    t.integer "cooking_time"
    t.text "description"
    t.boolean "is_public"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "users_id"
    t.index ["users_id"], name: "index_recipes_on_users_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "CreateUsers"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "inventories", "users", column: "users_id"
  add_foreign_key "inventory_foods", "foods", column: "foods_id"
  add_foreign_key "inventory_foods", "inventories", column: "inventories_id"
  add_foreign_key "recipe_foods", "foods", column: "foods_id"
  add_foreign_key "recipe_foods", "recipes", column: "recipes_id"
  add_foreign_key "recipes", "users", column: "users_id"
end
