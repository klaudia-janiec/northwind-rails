class Employee < ApplicationRecord
  belongs_to :superior, foreign_key: :reports_to, class_name: "Employee", optional: true
  has_many :inferiors, foreign_key: :reports_to, class_name: "Employee"
  has_many :orders
  has_many :employee_territories
  has_many :territories, through: :employee_territories

  validates :first_name, :last_name, presence: true
  validates :first_name, length: { maximum: 20 }
  validates :last_name, length: { maximum: 10 }
  validates :title, length: { maximum: 30 }
  validates :title_of_courtesy, length: { maximum: 25 }
  validates :address, length: { maximum: 60 }
  validates :city, :region, :country, length: { maximum: 15 }
  validates :postal_code, length: { maximum: 10 }
  validates :home_phone, length: { maximum: 24 }
  validates :extension, length: { maximum: 4 }
end
