class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details
  belongs_to :customer, optional: true
  belongs_to :employee, optional: true
  belongs_to :shipper, foreign_key: :ship_via, optional: true

  validates :ship_name, length: { maximum: 40 }
  validates :ship_address, length: { maximum: 60 }
  validates :ship_city, :ship_country, :ship_region, length: { maximum: 15 }
  validates :ship_postal_code, length: { maximum: 10 }

  accepts_nested_attributes_for :order_details, reject_if: :all_blank, allow_destroy: true
end
