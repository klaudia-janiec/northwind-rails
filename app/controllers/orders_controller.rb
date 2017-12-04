class OrdersController < ApplicationController
  before_action :order, only: %i[show destroy]
  def index
    @orders = Order.includes(:customer, :employee, :shipper, order_details: :product).order(:id).all
  end

  def show; end

  def new
    @shippers = Shipper.order(:id).all
    @customers = Customer.order(:id).all
    @employees = Employee.order(:id).all
    @products = Product.order(:id).all
    @order = Order.new
  end

  def create
    @order = Order.new(order_date: Time.zone.today)
    @order.assign_attributes(permitted_attributes)
    @order.order_details.each do |order_detail|
      order_detail.unit_price = order_detail.product&.unit_price
    end

    if @order.save
      redirect_to order_path(@order)
    else
      redirect_to new_order_path
      flash[:error] = @order.errors.full_messages
    end
  end

  def destroy
    if order.destroy
      redirect_to root_url
    else
      flash[:error] = order.errors.full_messages
    end
  end

  private

  def permitted_attributes
    params.require(:order).permit(:required_date,
                                  :customer_id,
                                  :employee_id,
                                  :required_date,
                                  :ship_via,
                                  :freight,
                                  :ship_name,
                                  :ship_address,
                                  :ship_city,
                                  :ship_region,
                                  :ship_postal_code,
                                  :ship_country,
                                  order_details_attributes: [:product_id, :quantity, :discount])
  end

  def order
    @order = Order.find(params[:id])
  end
end
