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

ActiveRecord::Schema.define(version: 2021_11_16_014242) do

  create_table "businesses", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.string "address"
    t.integer "zip_code"
    t.string "price"
    t.string "phone"
    t.string "display_phone"
    t.float "rating"
    t.string "img_url"
    t.float "longitude"
    t.float "latitude"
    t.string "hours"
    t.string "special_features"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "description"
    t.text "working_hours"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "business_id", null: false
    t.integer "user_id", null: false
    t.integer "rating"
    t.string "title"
    t.text "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_id"], name: "index_reviews_on_business_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "from_country"
    t.string "address"
    t.integer "work"
    t.integer "budget"
    t.integer "zip_code"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "reviews", "businesses"
  add_foreign_key "reviews", "users"
end
