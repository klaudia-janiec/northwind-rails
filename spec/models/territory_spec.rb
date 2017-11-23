require "rails_helper"

RSpec.describe Territory, type: :model do
  it { is_expected.to belong_to :region }
  it { is_expected.to have_many :employee_territories }
  it { is_expected.to have_many(:employees).through :employee_territories }

  it { is_expected.to validate_presence_of :territory_description }
  it { is_expected.to validate_length_of(:territory_description).is_at_most(50) }
end
