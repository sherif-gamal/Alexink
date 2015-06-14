class RemovePpunitFromProducts < ActiveRecord::Migration
  def change
  	remove_column :products, :price_per_unit
  end
end
