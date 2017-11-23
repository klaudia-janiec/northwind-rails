Fabricator(:employee) do
  first_name { FFaker::Name.first_name[0,9] }
  last_name { FFaker::Name.last_name[0,19] }
  title { FFaker::Job.title[0,29] }
  title_of_courtesy { FFaker::Job.title[0,24] }
  birth_date { rand(30.years).seconds.ago - 20.years }
  hire_date { rand(10.years).seconds.ago }
  address { FFaker::Address.street_address[0,59] }
  city { FFaker::Address.city[0,14] }
  region { FFaker::AddressUK.county[0,14] }
  country { FFaker::Address.country[0,14] }
  postal_code { FFaker::AddressUK.postcode[0,9] }
  home_phone { FFaker::PhoneNumber.short_phone_number[0,23] }
  extension { FFaker::Lorem.word[0,3] }
end
