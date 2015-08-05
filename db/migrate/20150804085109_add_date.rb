class AddDate < ActiveRecord::Migration
  def change

  	add_column :materials, :date_added, :string
  	add_column :purchases, :date_added, :string
  	add_column :productions, :date_added, :string
  	add_column :expenses, :date_added, :string
  end
end
