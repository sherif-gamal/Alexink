class AddTransactionFor < ActiveRecord::Migration
  def change
  	add_column :release_money_permissions, :transaction_for, :integer
  end
end
