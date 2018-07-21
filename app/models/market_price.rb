class MarketPrice < ApplicationRecord
  monetize :value_cents
  validates :value_cents,
            presence: true,
            numericality:
              { greater_than_or_equal_to: 0,
                less_than: 100_000_000 }
  validates :currency,
            presence: true,
            uniqueness: { scope: :value_cents }
end
