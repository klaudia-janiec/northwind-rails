require "rails_helper"

RSpec.describe CustomerCustomerDemo, type: :model do
  subject { Fabricate(:customer_customer_demo) }

  it { is_expected.to validate_uniqueness_of(:customer_type_id).scoped_to(:customer_id) }
end
