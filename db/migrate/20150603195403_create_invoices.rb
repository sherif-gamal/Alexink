class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :purchase_id

      t.timestamps null: false
    end
  end
end
