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

ActiveRecord::Schema.define(version: 20171010155825) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "category_name", limit: 15, null: false
    t.text "description"
    t.binary "picture"
  end

  create_table "customer_customer_demos", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "customer_type_id", null: false
    t.index ["customer_id", "customer_type_id"], name: "index_cust_cust_demos_cust_id_cust_type_id", unique: true
    t.index ["customer_id"], name: "index_customer_customer_demos_on_customer_id"
    t.index ["customer_type_id"], name: "index_customer_customer_demos_on_customer_type_id"
  end

  create_table "customer_demographics", primary_key: "customer_type_id", force: :cascade do |t|
    t.text "customer_description"
  end

  create_table "customers", force: :cascade do |t|
    t.string "company_name", limit: 40, null: false
    t.string "contact_name", limit: 30
    t.string "contact_title", limit: 30
    t.string "address", limit: 60
    t.string "city", limit: 15
    t.string "region", limit: 15
    t.string "postal_code", limit: 10
    t.string "country", limit: 15
    t.string "phone", limit: 24
    t.string "fax", limit: 24
  end

  create_table "employee_territories", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.bigint "territory_id", null: false
    t.index ["employee_id", "territory_id"], name: "index_employee_territories_on_employee_id_and_territory_id", unique: true
    t.index ["employee_id"], name: "index_employee_territories_on_employee_id"
    t.index ["territory_id"], name: "index_employee_territories_on_territory_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "last_name", limit: 20, null: false
    t.string "first_name", limit: 10, null: false
    t.string "title", limit: 30
    t.string "title_of_courtesy", limit: 25
    t.date "birth_date"
    t.date "hire_date"
    t.string "address", limit: 60
    t.string "city", limit: 15
    t.string "region", limit: 15
    t.string "postal_code", limit: 10
    t.string "country", limit: 15
    t.string "home_phone", limit: 24
    t.string "extension", limit: 4
    t.binary "photo"
    t.text "notes"
    t.bigint "reports_to"
    t.string "photo_path"
    t.index ["reports_to"], name: "index_employees_on_reports_to"
  end

  create_table "order_details", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "order_id", null: false
    t.integer "unit_price", null: false
    t.integer "quantity", limit: 2, null: false
    t.decimal "discount", null: false
    t.index ["order_id"], name: "index_order_details_on_order_id"
    t.index ["product_id", "order_id"], name: "index_order_details_on_product_id_and_order_id", unique: true
    t.index ["product_id"], name: "index_order_details_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "customer_id"
    t.bigint "employee_id"
    t.date "order_date"
    t.date "required_date"
    t.date "shipped_date"
    t.bigint "ship_via"
    t.integer "freight"
    t.string "ship_name", limit: 40
    t.string "ship_address", limit: 60
    t.string "ship_city", limit: 15
    t.string "ship_region", limit: 15
    t.string "ship_postal_code", limit: 10
    t.string "ship_country", limit: 15
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["employee_id"], name: "index_orders_on_employee_id"
    t.index ["ship_via"], name: "index_orders_on_ship_via"
  end

  create_table "products", force: :cascade do |t|
    t.string "product_name", limit: 40, null: false
    t.bigint "supplier_id"
    t.bigint "category_id"
    t.string "quantity_per_unit", limit: 20
    t.integer "unit_price"
    t.integer "units_in_stock", limit: 2
    t.integer "units_on_order", limit: 2
    t.integer "reorder_level", limit: 2
    t.integer "discountinued", null: false
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["supplier_id"], name: "index_products_on_supplier_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string "region_description", limit: 50, null: false
  end

  create_table "shippers", force: :cascade do |t|
    t.string "company_name", limit: 40, null: false
    t.string "phone", limit: 24
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "company_name", limit: 40, null: false
    t.string "contact_name", limit: 30
    t.string "contact_title", limit: 30
    t.string "address", limit: 60
    t.string "city", limit: 15
    t.string "region", limit: 15
    t.string "postal_code", limit: 10
    t.string "country", limit: 15
    t.string "phone", limit: 24
    t.string "fax", limit: 24
    t.string "home_page"
  end

  create_table "territories", force: :cascade do |t|
    t.string "territory_description", limit: 50, null: false
    t.bigint "region_id"
    t.index ["region_id"], name: "index_territories_on_region_id"
  end

  add_foreign_key "customer_customer_demos", "customer_demographics", column: "customer_type_id", primary_key: "customer_type_id"
  add_foreign_key "customer_customer_demos", "customers"
  add_foreign_key "employee_territories", "employees"
  add_foreign_key "employee_territories", "territories"
  add_foreign_key "employees", "employees", column: "reports_to"
  add_foreign_key "order_details", "orders"
  add_foreign_key "order_details", "products"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "employees"
  add_foreign_key "orders", "shippers", column: "ship_via"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "suppliers"
  add_foreign_key "territories", "regions"
end
