class OrdersController < ApplicationController
  def index
    @orders = Order.includes(:customer, :employee, :shipper, order_details: :product).order(:id).all
  end
end
