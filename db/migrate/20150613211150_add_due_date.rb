class AddDueDate < ActiveRecord::Migration
  def change
  	add_column :materials, :due_date, :string
  	add_column :purchases, :due_date, :string
  end
end
