class AddInternalToMaterial < ActiveRecord::Migration
  def change
  	add_column :materials, :internal, :integer
  end
end
