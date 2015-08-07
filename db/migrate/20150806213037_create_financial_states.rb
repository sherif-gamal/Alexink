class CreateFinancialStates < ActiveRecord::Migration
  def change
    create_table :financial_states do |t|
      t.float :osool, default: 0
      t.float :ehlak_osool, default: 0
      t.float :stock, default: 0
      t.float :ats, default: 0
      t.float :clients, default: 0
      t.float :treasury, default: 0
      t.float :m_advance, default: 0
      t.float :suppliers, default: 0
      t.float :debts, default: 0
      t.float :taxes_for_us, default: 0
      t.float :foreign_suppliers, default: 0
      t.float :taxes_delayed, default: 0
      t.float :expenses, default: 0
      t.float :working_capital, default: 0
      t.float :capital, default: 0
      t.float :fiat_investments, default: 0
      t.float :delayed_profits, default: 0
      t.float :year_profits, default: 0
      t.integer :year
      t.timestamps null: false
    end
  end
end
