class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer 	:purchase_id
      t.float	:debt

      t.timestamps null: false
    end
  end
end
