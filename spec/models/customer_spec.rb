require "rails_helper"

RSpec.describe Customer, type: :model do
  it { is_expected.to have_many(:customer_customer_demos) }
  it { is_expected.to have_many(:customer_demographics).through(:customer_customer_demos) }
  it { is_expected.to have_many(:orders) }

  it { is_expected.to validate_presence_of(:company_name) }
  it { is_expected.to validate_length_of(:company_name).is_at_most(40) }
  it { is_expected.to validate_length_of(:contact_name).is_at_most(30) }
  it { is_expected.to validate_length_of(:contact_title).is_at_most(30) }
  it { is_expected.to validate_length_of(:address).is_at_most(60) }
  it { is_expected.to validate_length_of(:city).is_at_most(15) }
  it { is_expected.to validate_length_of(:region).is_at_most(15) }
  it { is_expected.to validate_length_of(:country).is_at_most(15) }
  it { is_expected.to validate_length_of(:postal_code).is_at_most(10) }
  it { is_expected.to validate_length_of(:phone).is_at_most(24) }
  it { is_expected.to validate_length_of(:fax).is_at_most(24) }
end
