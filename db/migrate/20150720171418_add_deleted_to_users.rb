class AddDeletedToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :deleted, :integer
  end
end
