class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :expenses, :type, :e_type
  end
end
