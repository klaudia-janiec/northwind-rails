class ReportsController < ApplicationController
  def index
    @categories = Category.order(:id).all
  end

  def customers_without_orders
    set_parameters[:report]
    @customers = CustomersWithoutOrders.new(@parameters).call
  end

  private

  def set_parameters
    @parameters ||= params.require(:report).permit(:start_date, :end_date, :category)
  end
end
