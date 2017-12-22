class ReportsController < ApplicationController


  def index;
    @categories = Category.order(:id).all
  end

  def create;
    @report = params["report"]
    @start_date = @report["start_date"]
    @end_date = @report["end_date"]
    @category = @report["category"]

    # http://www.sqlfiddle.com/#!17/a45cb/12
    @customers = Customer.joins("
      LEFT OUTER JOIN (
        SELECT orders.customer_id
        FROM orders JOIN order_details
          ON orders.id = order_details.order_id
          AND orders.order_date BETWEEN '#{@start_date}' AND '#{@end_date}'
        JOIN products
          ON order_details.product_id = products.id
        JOIN categories
          ON products.category_id = categories.id
          AND categories.category_name LIKE '#{@category}'
        ) AS orders_query
      ON
        customers.id = orders_query.customer_id
      WHERE orders_query.customer_id is NULL"
    )

    # The same as above I've tried with Hash syntax, but with no success.
    # time_range = @start_date..@end_date
    # @customers = Customer.left_outer_joins(
    #     Order.joins(order_details: [{product: :category}])
    #          .where(orders: {order_date: time_range}, categories: {id: @category_id})
    # )

    @title = "Lista klientów, którzy nie złożyli żadnego zamówienia na produkt z kategorii '#{@category}'
              w okresie od #{@start_date} do #{@end_date}."

  end

end
