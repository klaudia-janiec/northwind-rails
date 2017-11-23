require "rails_helper"

RSpec.describe CustomerDemographic, type: :model do
  it { is_expected.to have_many(:customer_customer_demos) }
  it { is_expected.to have_many(:customers).through(:customer_customer_demos) }
end
