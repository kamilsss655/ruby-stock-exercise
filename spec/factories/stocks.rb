# == Schema Information
#
# Table name: stocks
#
#  id              :integer          not null, primary key
#  name            :string
#  bearer_id       :integer
#  market_price_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryBot.define do
  factory :stock do
    name 'Bayabongo Energy Corp'
    bearer
    market_price
  end
end
