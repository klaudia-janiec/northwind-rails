class OrdersController < ApplicationController
  before_action :order, only: %i[show destroy]
  def index
    @orders = Order.includes(:customer, :employee, :shipper, order_details: :product).order(:id).all
  end

  def show; end

  def destroy
    if order.destroy
      redirect_to root_url
    else
      flash[:error] = order.errors.full_messages
    end
  end

  private

  def order
    @order = Order.find(params[:id])
  end
end
