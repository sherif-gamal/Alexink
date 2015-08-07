class CreateIncomeMenus < ActiveRecord::Migration
  def change
    create_table :income_menus do |t|
      t.float :sales
      t.float :sales_payoff
      t.float :general_expenses
      t.float :sales_expenses
      t.float :exchange_loss
      t.float :ehlak
      t.float :exchange_profit
      t.float :other_income
      t.integer :year
      t.timestamps null: false
    end
  end
end
