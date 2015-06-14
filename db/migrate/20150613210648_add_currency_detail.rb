class AddCurrencyDetail < ActiveRecord::Migration
  def change
  	add_column :materials, :currency, :string
  end
end
