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
#  deleted_at      :datetime
#

class Stock < ApplicationRecord
  include SoftDeletable

  belongs_to :bearer,
             inverse_of: :stocks
  belongs_to :market_price,
             inverse_of: :stocks

  validates_with ForbiddenNameValidator
end
