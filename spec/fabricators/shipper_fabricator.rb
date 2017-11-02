Fabricator(:shipper) do
  company_name { FFaker::Company.name[0,39] }
  phone { FFaker::PhoneNumber.short_phone_number[0,23] }
end
