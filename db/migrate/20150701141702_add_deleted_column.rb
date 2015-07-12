class AddDeletedColumn < ActiveRecord::Migration
  def change
  	add_column :clients, :deleted, :integer
  	add_column :suppliers, :deleted, :integer
  	add_column :raw_materials, :deleted, :integer
  	add_column :products, :deleted, :integer
  end
end
