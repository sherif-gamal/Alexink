class AddCurrencyDetail < ActiveRecord::Migration
  def change
  	add_column :materials, :currency, :string
  	add_column :purchases, :currency, :string
  end
end
