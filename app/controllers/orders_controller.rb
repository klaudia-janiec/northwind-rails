class OrdersController < ApplicationController
  before_action :set_order, only: %i[show destroy update edit]
  before_action :set_associations, only: %i[new edit]

  def index
    @orders = Order.includes(:customer, :employee, :shipper, order_details: :product).order(:id).all
  end

  def show; end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_date: Time.zone.today)
    @order.assign_attributes(permitted_attributes)

    if @order.save
      redirect_to order_path(@order)
    else
      redirect_to new_order_path
      flash[:error] = @order.errors.full_messages
    end
  end

  def edit; end

  def update
    @order.assign_attributes(permitted_attributes)

    if @order.save
      redirect_to order_path(@order)
    else
      redirect_to @order
      flash[:error] = @order.errors.full_messages
    end
  end

  def destroy
    if @order.destroy
      redirect_to root_url
    else
      flash[:error] = @order.errors.full_messages
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
                                  order_details_attributes: [:id, :product_id, :quantity, :discount, :_destroy])
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def set_associations
    @shippers = Shipper.order(:id).all
    @customers = Customer.order(:id).all
    @employees = Employee.order(:id).all
    @products = Product.order(:id).all
  end
end
