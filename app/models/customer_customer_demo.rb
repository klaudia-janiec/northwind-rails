class CustomerCustomerDemo < ApplicationRecord
  belongs_to :customer_type, autosave: true, class_name: "CustomerDemographic", inverse_of: :customer_customer_demos
  belongs_to :customer, autosave: true, inverse_of: :customer_customer_demos

  validates :customer_type_id, uniqueness: { scope: :customer_id }
end
