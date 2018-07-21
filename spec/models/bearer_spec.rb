# == Schema Information
#
# Table name: bearers
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Bearer, type: :model do
  subject(:bearer) { build :bearer }
  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:name) }
end
