require "rails_helper"

RSpec.describe EmployeeTerritory, type: :model do
  it { is_expected.to belong_to(:employee) }
  it { is_expected.to belong_to(:territory) }
end
