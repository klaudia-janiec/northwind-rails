class CustomersWithoutOrders
  attr_reader :category, :start_date, :end_date

  def initialize(start_date:, end_date:, category:)
    @start_date = start_date
    @end_date = end_date
    @category = category
  end

  def call
    customers = Customer.arel_table
    orders = Order.arel_table
    order_details = OrderDetail.arel_table
    products = Product.arel_table
    categories = Category.arel_table

    order_query = orders.project(orders[:customer_id])
                      .join(order_details).on(orders[:id].eq(order_details[:order_id]))
                      .join(products).on(order_details[:product_id].eq(products[:id]))
                      .join(categories).on(products[:category_id].eq(categories[:id]).and(categories[:category_name].matches("#{@category}")))
                      .where(orders[:order_date].between(Date.parse(@start_date)..Date.parse(@end_date)))
                      .as('order_query')

    customers_query = customers
                          .join(order_query, Arel::Nodes::OuterJoin).on(order_query[:customer_id].eq(customers[:id]))
                          .join_sources

    Customer.joins(customers_query).where(order_query[:customer_id].eq(nil))
  end

  # vide examplum: http://www.sqlfiddle.com/#!17/a45cb/12
  # SELECT * FROM customers
  # LEFT OUTER JOIN (
  #   SELECT orders.customer_id
  #   FROM orders JOIN order_details
  #   ON orders.id = order_details.order_id
  #     AND orders.order_date BETWEEN '#{@parameters[:start_date]}' AND '#{@parameters[:end_date]}'
  #   JOIN products
  #     ON order_details.product_id = products.id
  #   JOIN categories
  #     ON products.category_id = categories.id
  #     AND categories.category_name LIKE '#{@parameters[:category]}'
  #   ) AS orders_query
  # ON customers.id = orders_query.customer_id
  # WHERE orders_query.customer_id is NULL;
end
