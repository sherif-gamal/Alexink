class CreateReleaseMoneyPermissions < ActiveRecord::Migration
  def change
    create_table :release_money_permissions do |t|
      t.integer :transaction_id
      t.integer :quantity
      t.timestamps null: false
    end
  end
end
