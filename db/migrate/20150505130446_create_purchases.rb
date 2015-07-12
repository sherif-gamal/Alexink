class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :product_ids
      t.string 	:quantities
      t.string 	:prices
      t.integer :client_id
      t.string	:payment_method
      t.string	:payment_state
      t.string	:state
      t.integer :invoice_id
      t.integer :debt
      t.string  :user_name
      t.integer :permission_id
      t.float   :price
      t.integer :calc_sub_tax

      t.timestamps null: false
    end

    add_index :purchases, :client_id
  end


end
