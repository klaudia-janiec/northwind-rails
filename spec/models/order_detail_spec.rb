require "rails_helper"

RSpec.describe OrderDetail, type: :model do
  it { is_expected.to belong_to :order }
  it { is_expected.to belong_to :product }

  it { is_expected.to validate_presence_of :unit_price }
  it { is_expected.to validate_presence_of :quantity }
  it { is_expected.to validate_presence_of :discount }
  it { is_expected.to validate_numericality_of(:quantity).is_less_than_or_equal_to(32767).is_greater_than(0) }
end
