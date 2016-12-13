# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20161213123731) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "DietaryViolations_Homepages", id: false, force: :cascade do |t|
    t.integer "homepage_id",          null: false
    t.integer "dietary_violation_id", null: false
  end

  create_table "Homepages_RestaurantCuisines", id: false, force: :cascade do |t|
    t.integer "homepage_id",           null: false
    t.integer "restaurant_cuisine_id", null: false
  end

  create_table "dietaryviolations", force: :cascade do |t|
    t.string "ingredient", limit: 50, null: false
    t.string "diet",       limit: 50, null: false
  end

  create_table "dishes", primary_key: "d_id", force: :cascade do |t|
    t.integer "r_id",                 null: false
    t.integer "m_id",                 null: false
    t.string  "name",     limit: 100, null: false
    t.float   "price",                null: false
    t.float   "rating"
    t.string  "cuisine",  limit: 50
    t.integer "calories"
  end

  create_table "dishingredients", id: false, force: :cascade do |t|
    t.integer "d_id",                  null: false
    t.string  "ingredient", limit: 50
  end

  create_table "homepages", force: :cascade do |t|
    t.string   "d_name"
    t.string   "r_name"
    t.integer  "c_min"
    t.integer  "c_max"
    t.integer  "r_min"
    t.integer  "r_max"
    t.integer  "p_min"
    t.integer  "p_max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredients", primary_key: "i_id", force: :cascade do |t|
    t.string "name", limit: 50, null: false
  end

  create_table "restaurantcuisines", force: :cascade do |t|
    t.integer "r_id",               null: false
    t.string  "cuisine", limit: 50, null: false
  end

  create_table "restaurantmenus", id: false, force: :cascade do |t|
    t.integer "r_id",             null: false
    t.integer "m_id",             null: false
    t.string  "name", limit: 100, null: false
  end

  create_table "restaurants", primary_key: "r_id", force: :cascade do |t|
    t.string "name", limit: 100, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
  end

  add_foreign_key "dishingredients", "dishes", column: "d_id", primary_key: "d_id", name: "dishingredients_d_id_fkey"
  add_foreign_key "restaurantcuisines", "restaurants", column: "r_id", primary_key: "r_id", name: "restaurantcuisines_r_id_fkey"
  add_foreign_key "restaurantmenus", "restaurants", column: "r_id", primary_key: "r_id", name: "restaurantmenus_r_id_fkey"
end
