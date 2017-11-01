class CustomerCustomerDemo < ApplicationRecord
  belongs_to :customer_type, class_name: "CustomerDemographic"
  belongs_to :customer

  validates :customer_type_id, uniqueness: { scope: :customer_id }
end
