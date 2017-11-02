Fabricator(:customer) do
  company_name { FFaker::Company.name[0,39] }
  contact_name { FFaker::Name.name[0,29] }
  contact_title { FFaker::Job.title[0,29] }
  address { FFaker::Address.street_address[0,59] }
  city { FFaker::Address.city[0,14] }
  region { FFaker::AddressUK.county[0,14] }
  postal_code { FFaker::AddressUK.postcode[0,9] }
  country { FFaker::Address.country[0,14] }
  phone { FFaker::PhoneNumber.short_phone_number[0,23] }
  fax { FFaker::PhoneNumber.short_phone_number[0,23] }
end
