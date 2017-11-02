require "rails_helper"

RSpec.describe Product, type: :model do
  it { is_expected.to belong_to :supplier }
  it { is_expected.to belong_to :category }
  it { is_expected.to have_many :order_details }
  it { is_expected.to have_many(:orders).through :order_details }

  it { is_expected.to validate_presence_of :product_name }
  it { is_expected.to validate_presence_of :discountinued }
  it { is_expected.to validate_length_of(:product_name).is_at_most(40) }
  it { is_expected.to validate_length_of(:quantity_per_unit).is_at_most(20) }
  it { is_expected.to validate_numericality_of(:units_in_stock).is_less_than_or_equal_to(32767).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:units_on_order).is_less_than_or_equal_to(32767).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:reorder_level).is_less_than_or_equal_to(32767).is_greater_than(0) }
end
