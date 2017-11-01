class Territory < ApplicationRecord
  belongs_to :region
  has_many :employee_territories
  has_many :employees, through: :employee_territories

  validates :territory_description, length: { maximum: 50 }, presence: true
end
