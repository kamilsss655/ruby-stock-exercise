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
  factory :market_price do
    currency 'usd'
    value_cents 100
  end
  factory :market_price_x_1, class: MarketPrice do
    currency 'eur'
    value_cents 3040
  end
end
