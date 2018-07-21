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

ActiveRecord::Schema.define(version: 20180721140248) do

  create_table "bearers", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_bearers_on_name", unique: true
  end

  create_table "market_prices", force: :cascade do |t|
    t.string   "currency",    null: false
    t.integer  "value_cents", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["currency", "value_cents"], name: "index_market_prices_on_currency_and_value_cents", unique: true
  end

end
