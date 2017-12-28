class ChangeOrderColumnInOrderDetails < ActiveRecord::Migration[5.1]
  def up
    rename_table :order_details, :order_details_deprecated
    create_table :order_details do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :unit_price, null: false
      t.integer :quantity, null: false, limit: 2
      t.decimal :discount, null: false
    end
    add_index :order_details, [:product_id, :order_id], unique: true

    sql = <<-SQL.squish
      INSERT INTO order_details (order_id, product_id, unit_price, quantity, discount)
      SELECT order_id, product_id, unit_price, quantity, discount FROM order_details_deprecated;
    SQL
    ActiveRecord::Base.connection.execute(sql)

    drop_table :order_details_deprecated
  end

  def down
    rename_table :order_details, :order_details_deprecated
    create_table :order_details do |t|
      t.references :product, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.integer :unit_price, null: false
      t.integer :quantity, null: false, limit: 2
      t.decimal :discount, null: false
    end
    add_index :order_details, [:product_id, :order_id], unique: true

    sql = <<-SQL.squish
      INSERT INTO order_details (product_id, order_id, unit_price, quantity, discount)
      SELECT product_id, order_id, unit_price, quantity, discount FROM order_details_deprecated;
    SQL
    ActiveRecord::Base.connection.execute(sql)

    drop_table :order_details_deprecated
  end
end
