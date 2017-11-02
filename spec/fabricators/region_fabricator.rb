Fabricator(:region) do
  territories(count: 1) { Fabricate.build(:territory, region: nil) }
  region_description { FFaker::Lorem.sentence[0,49] }
end
