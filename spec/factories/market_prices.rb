# == Schema Information
#
# Table name: market_prices
#
#  id          :integer          not null, primary key
#  currency    :string           not null
#  value_cents :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  # Factories
  factory :market_price do
    currency 'usd'
    value_cents
  end
  factory :market_price_x_1, class: MarketPrice do
    currency 'eur'
    value_cents 3040
  end
  # Sequences
  sequence :value_cents do |n|
    n + 100
  end
end
