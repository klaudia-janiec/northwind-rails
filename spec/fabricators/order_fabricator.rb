Fabricator(:order) do
  before_save do |order|
    order.order_date = rand(1.year).seconds.ago
    order.required_date = order.order_date + rand(1.month).seconds
    order.shipped_date = order.order_date + rand(1.month).seconds
  end
  ship_name { FFaker::Company.name[0,39] }
  ship_address { FFaker::Address.street_address[0,59] }
  ship_city { FFaker::Address.city[0,14] }
  ship_region { FFaker::AddressUK.county[0,14] }
  ship_country { FFaker::Address.country[0,14] }
  ship_postal_code { FFaker::AddressUK.postcode[0,9] }
end
