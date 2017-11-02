Fabricator(:product) do
  supplier
  category
  product_name { FFaker::Product.product_name[0,39] }
  quantity_per_unit { "#{Random.rand(1..100)} #{FFaker::UnitMetric.mass_abbr}" }
  units_in_stock { Random.rand(1..32767) }
  units_on_order { Random.rand(1..32767) }
  reorder_level { Random.rand(1..32767) }
  discountinued { Random.rand(1..32767) }
end
