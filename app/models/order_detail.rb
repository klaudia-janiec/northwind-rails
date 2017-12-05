class OrderDetail < ApplicationRecord
  before_validation :set_unit_price

  belongs_to :order, inverse_of: :order_details
  belongs_to :product

  validates :unit_price, :quantity, :discount, presence: true
  validates :quantity, numericality: { less_than_or_equal_to: 32767, greater_than: 0 }

  private

  def set_unit_price
    self.unit_price = product&.unit_price
  end
end
