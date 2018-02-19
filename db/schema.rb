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

ActiveRecord::Schema.define(version: 20180218233825) do

  create_table "accounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "account_name"
    t.float "account_value", limit: 24
    t.float "january_income", limit: 24, default: 0.0
    t.float "february_income", limit: 24, default: 0.0
    t.float "march_income", limit: 24, default: 0.0
    t.float "april_income", limit: 24, default: 0.0
    t.float "may_income", limit: 24, default: 0.0
    t.float "june_income", limit: 24, default: 0.0
    t.float "july_income", limit: 24, default: 0.0
    t.float "august_income", limit: 24, default: 0.0
    t.float "septermber_income", limit: 24, default: 0.0
    t.float "october_income", limit: 24, default: 0.0
    t.float "novemeber_income", limit: 24, default: 0.0
    t.float "december_income", limit: 24, default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stocks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "ticker"
    t.integer "shares", default: 0
    t.float "dividend_yield", limit: 24, default: 0.0
    t.date "ex_date"
    t.float "income", limit: 24, default: 0.0
    t.string "dividend_type"
    t.float "january_income", limit: 24, default: 0.0
    t.float "february_income", limit: 24, default: 0.0
    t.float "march_income", limit: 24, default: 0.0
    t.float "april_income", limit: 24, default: 0.0
    t.float "may_income", limit: 24, default: 0.0
    t.float "june_income", limit: 24, default: 0.0
    t.float "july_income", limit: 24, default: 0.0
    t.float "august_income", limit: 24, default: 0.0
    t.float "septermber_income", limit: 24, default: 0.0
    t.float "october_income", limit: 24, default: 0.0
    t.float "novemeber_income", limit: 24, default: 0.0
    t.float "december_income", limit: 24, default: 0.0
    t.string "company_details"
    t.float "stock_price", limit: 24, default: 0.0
    t.float "eps", limit: 24, default: 0.0
    t.float "pe", limit: 24, default: 0.0
    t.float "market_cap", limit: 24, default: 0.0
    t.float "enterprise_value", limit: 24, default: 0.0
    t.string "company_name"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "declared_amount", limit: 24, default: 0.0
    t.float "yearly_income", limit: 24, default: 0.0
    t.index ["account_id"], name: "index_stocks_on_account_id"
  end

end
