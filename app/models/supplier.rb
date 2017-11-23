class Supplier < ApplicationRecord
  has_many :products

  validates :company_name, presence: true, length: { maximum: 40 }
  validates :contact_name, :contact_title, length: { maximum: 30 }
  validates :address, length: { maximum: 60 }
  validates :city, :region, :country, length: { maximum: 15 }
  validates :postal_code, length: { maximum: 10 }
  validates :phone, :fax, length: { maximum: 24 }
end
