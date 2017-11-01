class Shipper < ApplicationRecord
  has_many :orders

  validates :company_name, presence: true, length: { maximum: 40 }
  validates :phone, length: { maximum: 24 }
end
