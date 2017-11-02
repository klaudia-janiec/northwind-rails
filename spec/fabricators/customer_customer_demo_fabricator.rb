Fabricator(:customer_customer_demo) do
  customer_type(fabricator: :customer_demographic, inverse_of: :customer_customer_demos)
  customer(inverse_of: :customer_customer_demos)
end
