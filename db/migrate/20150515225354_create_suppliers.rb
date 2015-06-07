class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
	    t.string  :name
      t.string  :country
      t.string  :address
      t.string  :zip
      t.string  :phone
      t.string  :email
      t.string  :contact_person
      t.integer :credit
      t.timestamps null: false
    end

  end
end
