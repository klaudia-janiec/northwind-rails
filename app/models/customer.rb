class Customer < ApplicationRecord
  has_many :customer_customer_demos
  has_many :customer_demographics, through: :customer_customer_demos
  has_many :orders

  validates :company_name, presence: true, length: { maximum: 40 }
  validates :contact_name, :contact_title, length: { maximum: 30 }
  validates :address, length: { maximum: 60 }
  validates :city, :region, :country, length: { maximum: 15 }
  validates :postal_code, length: { maximum: 10 }
  validates :phone, :fax, length: { maximum: 24 }
end
