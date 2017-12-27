class CustomersWithoutOrders
  attr_reader :category, :start_date, :end_date

  def initialize(parameters)
    @start_date = parameters[:start_date]
    @end_date = parameters[:end_date]
    @category = parameters[:category]
  end

  def call
    Customer.joins(customers_query).where(order_query[:customer_id].eq(nil))
  end

  private

  def customers_query
    customers
      .join(order_query, Arel::Nodes::OuterJoin).on(order_query[:customer_id].eq(customers[:id]))
      .join_sources
  end

  def order_query
    @order_query ||= orders
      .project(orders[:customer_id])
      .join(order_details).on(orders[:id].eq(order_details[:order_id]))
      .join(products).on(order_details[:product_id].eq(products[:id]))
      .join(categories).on(category_condition)
      .where(dates_condition)
      .as('order_query')
  end

  def category_condition
    products[:category_id].eq(categories[:id]).and(categories[:category_name].matches("#{category}"))
  end

  def dates_condition
    orders[:order_date].between(Date.parse(start_date)..Date.parse(end_date))
  end

  def categories
    @categories ||= Category.arel_table
  end

  def products
    @products ||= Product.arel_table
  end

  def order_details
    @order_details ||= OrderDetail.arel_table
  end

  def orders
    @orders ||= Order.arel_table
  end

  def customers
    @customers ||= Customer.arel_table
  end
end

