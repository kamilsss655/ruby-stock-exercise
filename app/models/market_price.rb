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

class MarketPrice < ApplicationRecord
  monetize :value_cents
  has_many :stocks,
           inverse_of: :market_price
  validates :value_cents,
            presence: true,
            numericality:
              { greater_than_or_equal_to: 0,
                less_than: 100_000_000 }
  validates :currency,
            presence: true,
            uniqueness: { scope: :value_cents }
end
