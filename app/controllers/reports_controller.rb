class ReportsController < ApplicationController
  def index
    @categories = Category.order(:id).all
  end

  def customers_without_orders
    set_parameters[:report]
    report = CustomersWithoutOrders.new(
        start_date: @parameters[:start_date],
        end_date: @parameters[:end_date],
        category: @parameters[:category])
    @customers = report.call
  end

  private

  def set_parameters
    @parameters ||= params.require(:report).permit(:start_date, :end_date, :category)
  end
end
