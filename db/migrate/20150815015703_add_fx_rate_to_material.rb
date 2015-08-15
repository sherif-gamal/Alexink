class AddFxRateToMaterial < ActiveRecord::Migration
  def change
  	add_column :materials, :fx_difference, :float
  end
end
