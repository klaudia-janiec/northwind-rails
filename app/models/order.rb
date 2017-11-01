class Order < ApplicationRecord
  has_many :order_details
  has_many :products, through: :order_details
  belongs_to :customer, optional: true
  belongs_to :employee, optional: true
  belongs_to :shipper, foreign_key: :ship_via, optional: true

  validates :ship_name, length: { maximum: 40 }
  validates :ship_address, length: { maximum: 60 }
  validates :ship_city, :ship_country, :ship_country, length: { maximum: 15 }
  validates :ship_postal_code, length: { maximum: 10 }
end
