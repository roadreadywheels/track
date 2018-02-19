class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
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
      t.timestamps
    end
  end
end
