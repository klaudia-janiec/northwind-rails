require "rails_helper"

RSpec.describe Employee, type: :model do
  it { is_expected.to belong_to(:superior) }
  it { is_expected.to have_many(:inferiors) }
  it { is_expected.to have_many(:orders) }
  it { is_expected.to have_many(:employee_territories) }
  it { is_expected.to have_many(:territories).through(:employee_territories) }

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_length_of(:first_name).is_at_most(10) }
  it { is_expected.to validate_length_of(:last_name).is_at_most(20) }
  it { is_expected.to validate_length_of(:title).is_at_most(30) }
  it { is_expected.to validate_length_of(:title_of_courtesy).is_at_most(25) }
  it { is_expected.to validate_length_of(:address).is_at_most(60) }
  it { is_expected.to validate_length_of(:city).is_at_most(15) }
  it { is_expected.to validate_length_of(:region).is_at_most(15) }
  it { is_expected.to validate_length_of(:country).is_at_most(15) }
  it { is_expected.to validate_length_of(:postal_code).is_at_most(10) }
  it { is_expected.to validate_length_of(:home_phone).is_at_most(24) }
  it { is_expected.to validate_length_of(:extension).is_at_most(4) }
end
