class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string  :name
      t.string  :country
      t.string  :address
      t.string  :zip
      t.string  :phone
      t.string  :email
      t.string  :contact_person
      t.integer :debt
      t.timestamps null: false
    end
  end
end
