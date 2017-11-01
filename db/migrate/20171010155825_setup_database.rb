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
      t.string :home_page
    end

    create_table :products do |t|
      t.string :product_name, null: false, limit: 40
      t.references :supplier, foreign_key: true
      t.references :category, foreign_key: true
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

    create_table :territories do |t|
      t.string :territory_description, null: false, limit: 50
      t.references :region, foreign_key: true
    end

    create_table :employees do |t|
      t.string :last_name, limit: 20, null: false
      t.string :first_name, limit: 10, null: false
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
      t.bigint :reports_to, index: true
      t.string :photo_path
    end
    add_foreign_key :employees, :employees, column: :reports_to

    create_table :employee_territories do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :territory, null: false, foreign_key: true
    end
    add_index :employee_territories, [:employee_id, :territory_id], unique: true

    create_table :shippers do |t|
      t.string :company_name, limit: 40, null: false
      t.string :phone, limit: 24
    end

    create_table :orders do |t|
      t.references :customer, foreign_key: true
      t.references :employee, foreign_key: true
      t.date :order_date
      t.date :required_date
      t.date :shipped_date
      t.bigint :ship_via, index: true
      t.integer :freight
      t.string :ship_name, limit: 40
      t.string :ship_address, limit: 60
      t.string :ship_city, limit: 15
      t.string :ship_region, limit: 15
      t.string :ship_postal_code, limit: 10
      t.string :ship_country, limit: 15
    end
    add_foreign_key :orders, :shippers, column: :ship_via

    create_table :order_details do |t|
      t.references :product, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.integer :unit_price, null: false
      t.integer :quantity, null: false, limit: 2
      t.decimal :discount, null: false
    end
    add_index :order_details, [:product_id, :order_id], unique: true

    create_table :customer_demographics, id: false do |t|
      t.primary_key :customer_type_id
      t.text :customer_description
    end

    create_table :customer_customer_demos do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :customer_type, null: false
    end
    add_index :customer_customer_demos, [:customer_id, :customer_type_id], unique: true, name: "index_cust_cust_demos_cust_id_cust_type_id"
    add_foreign_key :customer_customer_demos, :customer_demographics, column: :customer_type_id, primary_key: :customer_type_id
  end
end
