class SetupDatabase < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :category_name, null: false, limit: 15
      t.text :description
      t.binary :picture
    end

    create_table :customers do |t|
      t.string :company_name, null: false, limit: 40
      t.string :contact_name, limit: 30
      t.string :contact_title, limit: 30
      t.string :address, limit: 60
      t.string :city, limit: 15
      t.string :region, limit: 15
      t.string :postal_code, limit: 10
      t.string :country, limit: 15
      t.string :phone, limit: 24
      t.string :fax, limit: 24
    end

    create_table :suppliers do |t|
      t.string :company_name, null: false, limit: 40
      t.string :contact_name, limit: 30
      t.string :contact_title, limit: 30
      t.string :address, limit: 60
      t.string :city, limit: 15
      t.string :region, limit: 15
      t.string :postal_code, limit: 10
      t.string :country, limit: 15
      t.string :phone, limit: 24
      t.string :fax, limit: 24
      t.text :home_page
    end

    create_table :products do |t|
      t.string :product_name, null: false, limit: 40
      t.references :supplier
      t.references :category
      t.string :quantity_per_unit, limit: 20
      t.integer :unit_price
      t.integer :units_in_stock, limit: 2
      t.integer :units_on_order, limit: 2
      t.integer :reorder_level, limit: 2
      t.integer :discountinued, null: false
    end

    create_table :regions do |t|
      t.string :region_description, null: false, limit: 50
    end

    create_table :teritories do |t|
      t.string :teritory_description, null: false, limit: 50
      t.references :region
    end

    create_table :employees do |t|
      t.string :last_name, limit: 20
      t.string :first_name, limit: 10
      t.string :title, limit: 30
      t.string :title_of_courtesy, limit: 25
      t.date :birth_date
      t.date :hire_date
      t.string :address, limit: 60
      t.string :city, limit: 15
      t.string :region, limit: 15
      t.string :postal_code, limit: 10
      t.string :country, limit: 15
      t.string :home_phone, limit: 24
      t.string :extension, limit: 4
      t.binary :photo
      t.text :notes
      t.integer :reports_to, index: true
      t.string :photo_path
    end

    create_table :employees_territories do |t|
      t.references :employee
      t.references :teritory
    end

    create_table :shippers do |t|
      t.string :company_name, limit: 40
      t.string :phone, limit: 24
    end

    create_table :orders do |t|
      t.references :customer
      t.references :employee
      t.date :order_date
      t.date :required_date
      t.date :shipped_date
      t.integer :ship_via, index: true
      t.integer :freight
      t.string :ship_name, limit: 40
      t.string :ship_address, limit: 60
      t.string :ship_city, limit: 15
      t.string :ship_region, limit: 15
      t.string :ship_postal_code, limit: 10
      t.string :ship_country, limit: 15
    end

    create_table :order_details do |t|
      t.references :product
      t.references :order
      t.integer :unit_price, null: false
      t.integer :quantity, null: false, limit: 2
      t.decimal :discount, null: false
    end

    create_table :customer_demos do |t|
      t.text :customer_description
    end

    create_table :customers_customer_demos do |t|
      t.references :customer
      t.references :customer_demo
    end

    add_foreign_key :orders, :shippers, column: :ship_via
    add_foreign_key :employees, :employees, column: :reports_to
    add_foreign_key :products, :suppliers
    add_foreign_key :products, :categories
    add_foreign_key :teritories, :regions
    add_foreign_key :employees_territories, :employees
    add_foreign_key :employees_territories, :teritories
    add_foreign_key :orders, :customers
    add_foreign_key :orders, :employees
    add_foreign_key :order_details, :products
    add_foreign_key :order_details, :orders
    add_foreign_key :customers_customer_demos, :customers
    add_foreign_key :customers_customer_demos, :customer_demos
  end
end
