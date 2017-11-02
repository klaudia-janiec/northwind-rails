Fabricator(:order_detail) do
  order
  product
  unit_price { Random.rand(1..1000) }
  quantity { Random.rand(1..32767) }
  discount { Random.rand(0..100) }
end
