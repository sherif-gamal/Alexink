class AddTypeToTreasury < ActiveRecord::Migration
  def change
  	add_column :treasury_diaries, :p_method, :string
  end
end
