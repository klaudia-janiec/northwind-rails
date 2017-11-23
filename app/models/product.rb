class Product < ApplicationRecord
  belongs_to :supplier, optional: true
  belongs_to :category, optional: true
  has_many :order_details
  has_many :orders, through: :order_details

  validates :product_name, presence: true, length: { maximum: 40 }
  validates :discountinued, presence: true
  validates :quantity_per_unit, length: { maximum: 20 }
  validates :units_in_stock, :units_on_order, :reorder_level, numericality: { less_than_or_equal_to: 32767, greater_than: 0 }
end
