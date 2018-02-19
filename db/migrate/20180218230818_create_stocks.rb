class CreateStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :stocks do |t|
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
      t.timestamps
    end
  end
end
