class Order < ApplicationRecord
  include Filterable

  has_many :order_details, inverse_of: :order, dependent: :destroy, autosave: true
  has_many :products, through: :order_details
  belongs_to :customer, optional: true
  belongs_to :employee, optional: true
  belongs_to :shipper, foreign_key: :ship_via, optional: true

  validates :ship_name, length: { maximum: 40 }
  validates :ship_address, length: { maximum: 60 }
  validates :ship_city, :ship_country, :ship_region, length: { maximum: 15 }
  validates :ship_postal_code, length: { maximum: 10 }

  accepts_nested_attributes_for :order_details, reject_if: :all_blank, allow_destroy: true

  scope :with_total_price, -> { select([orders[Arel.star]], total_price_query.as("total_price")).joins(:order_details).group(:id) }

  scope :customer, -> (customer_id) { where(customer_id: customer_id) }
  scope :employee, -> (employee_id) { where(employee_id: employee_id) }
  scope :shipper,  -> (shipper_id)  { where(ship_via: shipper_id) }
  scope :product,  -> (product_id)  { joins(:order_details).where(order_details: { product_id: product_id }) }
  scope :min_total_price, -> (min_total_price) { with_total_price.having(total_price_query.gteq(min_total_price)) }
  scope :max_total_price, -> (max_total_price) { with_total_price.having(total_price_query.lteq(max_total_price)) }

  private

  class << self
    def total_price_query
      Arel::Nodes::Addition.new(subtotal, orders[:freight])
    end

    def subtotal
      Arel::Nodes::Multiplication.new(order_details[:unit_price], Arel::Nodes::Multiplication.new(order_details[:quantity], discount)).sum
    end

    def discount
      Arel::Nodes::Grouping.new(Arel::Nodes::Subtraction.new(1, order_details[:discount]))
    end

    def order_details
      @order_details ||= OrderDetail.arel_table
    end

    def orders
      @orders ||= Order.arel_table
    end
  end
end
