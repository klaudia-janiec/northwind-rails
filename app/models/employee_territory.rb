class EmployeeTerritory < ApplicationRecord
  balongs_to :employee
  belongs_to :territory
end
