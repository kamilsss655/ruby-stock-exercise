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

require 'rails_helper'

RSpec.describe Stock, type: :model do
  it { should belong_to(:bearer) }
  it { should belong_to(:market_price) }
end
