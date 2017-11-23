Fabricator(:territory) do
  territory_description { FFaker::Lorem.sentence[0,49] }
end
