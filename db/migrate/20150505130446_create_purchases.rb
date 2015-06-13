class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :product_ids, array: true
      t.string 	:quantities, array: true
      t.string 	:prices, array: true
      t.integer :client_id
      t.string	:payment_method
      t.string	:payment_state
      t.string	:state
      t.integer :invoice_id
      t.integer :debt
      t.string  :user_name
      t.integer :permission_id
      t.float   :price

      t.timestamps null: false
    end

    add_index :purchases, :client_id
  end


end
