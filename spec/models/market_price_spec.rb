require 'rails_helper'

RSpec.describe MarketPrice, type: :model do
  subject(:marker_price) { build :market_price }
  it { should validate_presence_of(:value_cents) }
  it { should validate_presence_of(:currency) }
  it { should validate_uniqueness_of(:currency).scoped_to(:value_cents) }
  it {
    should validate_numericality_of(:value_cents)
      .is_greater_than_or_equal_to(0)
  }
  it { should validate_numericality_of(:value_cents).is_less_than(100_000_000) }
end
