require "rails_helper"

RSpec.describe Order, type: :model do
  it { is_expected.to have_many(:order_details) }
  it { is_expected.to have_many(:products).through(:order_details) }
  it { is_expected.to belong_to(:customer) }
  it { is_expected.to belong_to(:shipper) }
  it { is_expected.to belong_to(:employee) }

  it { is_expected.to validate_length_of(:ship_name).is_at_most(40) }
  it { is_expected.to validate_length_of(:ship_address).is_at_most(60) }
  it { is_expected.to validate_length_of(:ship_city).is_at_most(15) }
  it { is_expected.to validate_length_of(:ship_country).is_at_most(15) }
  it { is_expected.to validate_length_of(:ship_region).is_at_most(15) }
  it { is_expected.to validate_length_of(:ship_postal_code).is_at_most(10) }
end
