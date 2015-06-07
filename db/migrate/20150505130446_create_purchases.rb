class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :product_id
      t.float 	:quantity
      t.float 	:price
      t.integer :client_id
      t.string	:payment_method
      t.string	:payment_state
      t.string	:state
      t.integer :invoice_id
      t.integer :debt

      t.timestamps null: false
    end

    add_index :purchases, :client_id
    add_index :purchases, :product_id
  end


end
