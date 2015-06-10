class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.float 	:purchase_id
      t.float	:debt

      t.timestamps null: false
    end
  end
end
