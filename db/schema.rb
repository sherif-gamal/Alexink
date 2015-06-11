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

ActiveRecord::Schema.define(version: 20150610102107) do

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
  end

  create_table "invoices", force: :cascade do |t|
    t.float    "purchase_id"
    t.float    "debt"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "materials", force: :cascade do |t|
    t.integer  "raw_material_id"
    t.integer  "supplier_id"
    t.float    "quantity"
    t.float    "price"
    t.string   "payment_method"
    t.string   "payment_state"
    t.float    "debt"
    t.string   "state"
    t.integer  "in_stock"
    t.string   "user_name"
    t.integer  "permission_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "materials", ["supplier_id"], name: "index_materials_on_supplier_id"

  create_table "permissions", force: :cascade do |t|
    t.integer  "transaction_type"
    t.integer  "transaction_id"
    t.integer  "quantity"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "productions", force: :cascade do |t|
    t.integer  "raw_material_id"
    t.string   "user_name"
    t.float    "quantity"
    t.integer  "permission_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.string   "unit"
    t.float    "quantity"
    t.float    "price_per_unit"
    t.integer  "in_stock"
    t.text     "description"
    t.integer  "permission_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "purchases", force: :cascade do |t|
    t.integer  "product_id"
    t.float    "quantity"
    t.float    "price"
    t.integer  "client_id"
    t.string   "payment_method"
    t.string   "payment_state"
    t.string   "state"
    t.integer  "invoice_id"
    t.integer  "debt"
    t.string   "user_name"
    t.integer  "permission_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "purchases", ["client_id"], name: "index_purchases_on_client_id"
  add_index "purchases", ["product_id"], name: "index_purchases_on_product_id"

  create_table "raw_materials", force: :cascade do |t|
    t.string   "name"
    t.string   "unit"
    t.text     "description"
    t.integer  "in_stock"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
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
  end

  create_table "treasuries", force: :cascade do |t|
    t.integer  "bank"
    t.integer  "cash"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
