class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :unit_price, :quantity, :discount, presence: true
  validates :quantity, numericality: { less_than_or_equal_to: 32767, greater_than: 0 }
end
