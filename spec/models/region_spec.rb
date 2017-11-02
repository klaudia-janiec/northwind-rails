require "rails_helper"

RSpec.describe Region, type: :model do
  it { is_expected.to have_many :territories }

  it { is_expected.to validate_presence_of :region_description }
  it { is_expected.to validate_length_of(:region_description).is_at_most(50) }
end
