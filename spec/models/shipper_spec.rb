require "rails_helper"

RSpec.describe Shipper, type: :model do
  it { is_expected.to have_many :orders }

  it { is_expected.to validate_presence_of :company_name }
  it { is_expected.to validate_length_of(:company_name).is_at_most(40) }
  it { is_expected.to validate_length_of(:phone).is_at_most(24) }
end
