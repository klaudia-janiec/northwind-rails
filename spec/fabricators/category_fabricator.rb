Fabricator(:category) do
  category_name { FFaker::Lorem.word[0,14] }
end
