class CustomerDemographic < ApplicationRecord
  self.primary_key = "customer_type_id"

  has_many :customer_customer_demos
  has_many :customers, through: :customer_customer_demos
end
