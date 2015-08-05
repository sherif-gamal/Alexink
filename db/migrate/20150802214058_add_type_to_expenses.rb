class AddTypeToExpenses < ActiveRecord::Migration
  def change
  	add_column :expenses, :type, :integer
  end
end
