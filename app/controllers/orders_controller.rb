class OrdersController < ApplicationController
  def index
    @orders = Order.includes(:customer, :employee, :shipper, order_details: :product).order(:id).all
  end

  def show
    @order = Order.find(params[:id])
  end
end
