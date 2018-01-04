namespace :db do
  desc "Seeds database using fabricators"
  task seed_with_fabricators: :environment do
    ActiveRecord::Base.transaction do
      50.times do |i|
        Fabricate(:customer_customer_demo, customer_type: Fabricate(:customer_demographic), customer: Fabricate(:customer))
      end

      30.times { |i| Fabricate(:region) }
      10.times do |i|
        Fabricate(:territory, region: Region.order("RANDOM()").first)
      end

      100.times do |i|
        Fabricate(:employee_territory,
                  territory: Territory.order("RANDOM()").first,
                  employee: Fabricate(:employee, reports_to: Employee.order("RANDOM()").first&.id))
      end

      30.times { |i| Fabricate(:shipper) }

      40.times { |i| Fabricate(:supplier) }
      10.times { |i| Fabricate(:category) }

      70.times do |i|
        Fabricate(:product,
                  supplier: Random.rand(1...100) > 50 ? nil : Supplier.order("RANDOM()").first,
                  category: Random.rand(1...100) > 50 ? nil : Category.order("RANDOM()").first)
      end

      1000.times do |i|
        Fabricate(:order_detail,
                  order: Fabricate(:order,
                                   customer: Random.rand(1...100) > 50 ? nil : Customer.order("RANDOM()").first,
                                   employee: Random.rand(1...100) > 50 ? nil : Employee.order("RANDOM()").first,
                                   ship_via: Random.rand(1...100) > 50 ? nil : Shipper.order("RANDOM()").first&.id))
      end
    end
  end
end
