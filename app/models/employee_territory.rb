class EmployeeTerritory < ApplicationRecord
  belongs_to :employee
  belongs_to :territory
end
