class Shipper < ApplicationRecord
  has_many :orders, foreign_key: :ship_via

  validates :company_name, presence: true, length: { maximum: 40 }
  validates :phone, length: { maximum: 24 }
end
