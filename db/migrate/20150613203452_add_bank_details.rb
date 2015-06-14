class AddBankDetails < ActiveRecord::Migration
  def change

  	add_column :suppliers, :bank, :text
  	add_column :clients, :bank, :text
  end
end
