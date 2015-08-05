# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150805115206) do

  create_table "add_material_permissions", force: :cascade do |t|
    t.integer  "transaction_id"
    t.integer  "quantity"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "add_product_permissions", force: :cascade do |t|
    t.integer  "transaction_id"
    t.integer  "quantity"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.string   "country"
    t.string   "address"
    t.string   "zip"
    t.string   "phone"
    t.string   "email"
    t.string   "contact_person"
    t.integer  "debt"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.text     "bank"
    t.integer  "deleted"
  end

  create_table "ehlak_osools", force: :cascade do |t|
    t.string   "name"
    t.float    "rate"
    t.float    "value"
    t.float    "last_year_acc"
    t.integer  "year"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "expense_payment_details", force: :cascade do |t|
    t.float    "treasury_debt"
    t.float    "treasury_credit"
    t.float    "bnp_debt"
    t.float    "bnp_credit"
    t.float    "abu_dhabi_debt"
    t.float    "abu_dhabi_credit"
    t.float    "operation_expense_debt"
    t.float    "operation_expense_credit"
    t.float    "sale_expense_debt"
    t.float    "sale_expense_credit"
    t.float    "general_managerial_debt"
    t.float    "general_managerial_credit"
    t.float    "creditor_debt"
    t.float    "creditor_credit"
    t.float    "purchases_debt"
    t.float    "purchases_credit"
    t.float    "das_debt"
    t.float    "das_credit"
    t.float    "clients_debt"
    t.float    "clients_credit"
    t.float    "sales_debt"
    t.float    "sales_credit"
    t.float    "sales_tax_debt"
    t.float    "sales_tax_credit"
    t.float    "aq_debt"
    t.float    "aq_credit"
    t.float    "e3temadat_mostanadeya_debt"
    t.float    "e3temadat_mostanadeya_credit"
    t.float    "outer_suppliers_debt"
    t.float    "outer_suppliers_credit"
    t.float    "osool_sabta_debt"
    t.float    "osool_sabta_credit"
    t.float    "m_moshtarayat_debt"
    t.float    "m_moshtarayat_credit"
    t.float    "bnp_euro_debt"
    t.float    "bnp_euro_credit"
    t.float    "fx_difference_debt"
    t.float    "fx_difference_credit"
    t.float    "aq_rasm_ta7seel_debt"
    t.float    "aq_rasm_ta7seel_credit"
    t.float    "income_tax_debt"
    t.float    "income_tax_credit"
    t.float    "rental_debt"
    t.float    "rental_credit"
    t.float    "contributor_creditor_debt"
    t.float    "contributor_creditor_credit"
    t.float    "bnp_dollar_debt"
    t.float    "bnp_dollar_credit"
    t.float    "abu_dhabi_dollar_debt"
    t.float    "abu_dhabi_dollar_credit"
    t.float    "supplier_debt"
    t.float    "supplier_credit"
    t.float    "abu_dhabi_euro_debt"
    t.float    "abu_dhabi_euro_credit"
    t.float    "other_debt"
    t.float    "other_credit"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "expenses", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.string   "seller"
    t.string   "payment_method"
    t.string   "payment_state"
    t.float    "debt"
    t.string   "user_name"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "e_type"
    t.string   "date_added"
  end

  create_table "invoices", force: :cascade do |t|
    t.integer  "purchase_id"
    t.float    "debt"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "material_payment_details", force: :cascade do |t|
    t.float    "treasury_debt"
    t.float    "treasury_credit"
    t.float    "bnp_debt"
    t.float    "bnp_credit"
    t.float    "abu_dhabi_debt"
    t.float    "abu_dhabi_credit"
    t.float    "operation_expense_debt"
    t.float    "operation_expense_credit"
    t.float    "sale_expense_debt"
    t.float    "sale_expense_credit"
    t.float    "general_managerial_debt"
    t.float    "general_managerial_credit"
    t.float    "creditor_debt"
    t.float    "creditor_credit"
    t.float    "purchases_debt"
    t.float    "purchases_credit"
    t.float    "das_debt"
    t.float    "das_credit"
    t.float    "clients_debt"
    t.float    "clients_credit"
    t.float    "sales_debt"
    t.float    "sales_credit"
    t.float    "sales_tax_debt"
    t.float    "sales_tax_credit"
    t.float    "aq_debt"
    t.float    "aq_credit"
    t.float    "e3temadat_mostanadeya_debt"
    t.float    "e3temadat_mostanadeya_credit"
    t.float    "outer_suppliers_debt"
    t.float    "outer_suppliers_credit"
    t.float    "osool_sabta_debt"
    t.float    "osool_sabta_credit"
    t.float    "m_moshtarayat_debt"
    t.float    "m_moshtarayat_credit"
    t.float    "bnp_euro_debt"
    t.float    "bnp_euro_credit"
    t.float    "fx_difference_debt"
    t.float    "fx_difference_credit"
    t.float    "aq_rasm_ta7seel_debt"
    t.float    "aq_rasm_ta7seel_credit"
    t.float    "income_tax_debt"
    t.float    "income_tax_credit"
    t.float    "rental_debt"
    t.float    "rental_credit"
    t.float    "contributor_creditor_debt"
    t.float    "contributor_creditor_credit"
    t.float    "bnp_dollar_debt"
    t.float    "bnp_dollar_credit"
    t.float    "abu_dhabi_dollar_debt"
    t.float    "abu_dhabi_dollar_credit"
    t.float    "supplier_debt"
    t.float    "supplier_credit"
    t.float    "abu_dhabi_euro_debt"
    t.float    "abu_dhabi_euro_credit"
    t.float    "other_debt"
    t.float    "other_credit"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "materials", force: :cascade do |t|
    t.string   "raw_material_ids"
    t.string   "quantities"
    t.string   "prices"
    t.float    "price"
    t.integer  "supplier_id"
    t.string   "payment_method"
    t.string   "payment_state"
    t.float    "debt"
    t.string   "state"
    t.integer  "in_stock"
    t.string   "user_name"
    t.integer  "permission_id"
    t.integer  "calc_sub_tax"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "currency"
    t.string   "due_date"
    t.integer  "internal"
    t.string   "date_added"
  end

  add_index "materials", ["supplier_id"], name: "index_materials_on_supplier_id"

  create_table "product_expenses", force: :cascade do |t|
    t.integer  "product_id"
    t.float    "constant_expense"
    t.float    "raw_material_expense"
    t.float    "employment"
    t.float    "other"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "production_permissions", force: :cascade do |t|
    t.integer  "transaction_id"
    t.integer  "quantity"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "productions", force: :cascade do |t|
    t.integer  "raw_material_id"
    t.string   "user_name"
    t.float    "quantity"
    t.integer  "permission_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "date_added"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.string   "unit"
    t.float    "quantity"
    t.integer  "in_stock"
    t.text     "description"
    t.integer  "permission_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "deleted"
  end

  create_table "purchase_payment_details", force: :cascade do |t|
    t.float    "treasury_debt"
    t.float    "treasury_credit"
    t.float    "bnp_debt"
    t.float    "bnp_credit"
    t.float    "abu_dhabi_debt"
    t.float    "abu_dhabi_credit"
    t.float    "operation_expense_debt"
    t.float    "operation_expense_credit"
    t.float    "sale_expense_debt"
    t.float    "sale_expense_credit"
    t.float    "general_managerial_debt"
    t.float    "general_managerial_credit"
    t.float    "creditor_debt"
    t.float    "creditor_credit"
    t.float    "purchases_debt"
    t.float    "purchases_credit"
    t.float    "das_debt"
    t.float    "das_credit"
    t.float    "clients_debt"
    t.float    "clients_credit"
    t.float    "sales_debt"
    t.float    "sales_credit"
    t.float    "sales_tax_debt"
    t.float    "sales_tax_credit"
    t.float    "aq_debt"
    t.float    "aq_credit"
    t.float    "e3temadat_mostanadeya_debt"
    t.float    "e3temadat_mostanadeya_credit"
    t.float    "outer_suppliers_debt"
    t.float    "outer_suppliers_credit"
    t.float    "osool_sabta_debt"
    t.float    "osool_sabta_credit"
    t.float    "m_moshtarayat_debt"
    t.float    "m_moshtarayat_credit"
    t.float    "bnp_euro_debt"
    t.float    "bnp_euro_credit"
    t.float    "fx_difference_debt"
    t.float    "fx_difference_credit"
    t.float    "aq_rasm_ta7seel_debt"
    t.float    "aq_rasm_ta7seel_credit"
    t.float    "income_tax_debt"
    t.float    "income_tax_credit"
    t.float    "rental_debt"
    t.float    "rental_credit"
    t.float    "contributor_creditor_debt"
    t.float    "contributor_creditor_credit"
    t.float    "bnp_dollar_debt"
    t.float    "bnp_dollar_credit"
    t.float    "abu_dhabi_dollar_debt"
    t.float    "abu_dhabi_dollar_credit"
    t.float    "supplier_debt"
    t.float    "supplier_credit"
    t.float    "abu_dhabi_euro_debt"
    t.float    "abu_dhabi_euro_credit"
    t.float    "other_debt"
    t.float    "other_credit"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "purchases", force: :cascade do |t|
    t.string   "product_ids"
    t.string   "quantities"
    t.string   "prices"
    t.integer  "client_id"
    t.string   "payment_method"
    t.string   "payment_state"
    t.string   "state"
    t.integer  "invoice_id"
    t.integer  "debt"
    t.string   "user_name"
    t.integer  "permission_id"
    t.float    "price"
    t.integer  "calc_sub_tax"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "currency"
    t.string   "due_date"
    t.string   "date_added"
  end

  add_index "purchases", ["client_id"], name: "index_purchases_on_client_id"

  create_table "raw_materials", force: :cascade do |t|
    t.string   "name"
    t.string   "unit"
    t.text     "description"
    t.integer  "in_stock"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "deleted"
  end

  create_table "release_material_permissions", force: :cascade do |t|
    t.integer  "transaction_id"
    t.integer  "quantity"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "release_money_permissions", force: :cascade do |t|
    t.integer  "transaction_for"
    t.integer  "transaction_id"
    t.integer  "quantity"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "release_product_permissions", force: :cascade do |t|
    t.integer  "transaction_id"
    t.integer  "quantity"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "suppliers", force: :cascade do |t|
    t.string   "name"
    t.string   "country"
    t.string   "address"
    t.string   "zip"
    t.string   "phone"
    t.string   "email"
    t.string   "contact_person"
    t.integer  "credit"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.text     "bank"
    t.integer  "deleted"
  end

  create_table "treasuries", force: :cascade do |t|
    t.integer  "bank"
    t.integer  "cash"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "treasury_diaries", force: :cascade do |t|
    t.integer  "transaction_id"
    t.integer  "transaction_type"
    t.integer  "is_tax"
    t.float    "amount"
    t.string   "description"
    t.string   "cheque_num"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "p_method"
    t.string   "date_added"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "occupation"
    t.string   "department"
    t.string   "address"
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "phone"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "deleted"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
