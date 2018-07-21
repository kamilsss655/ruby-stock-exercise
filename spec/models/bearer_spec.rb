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
  context 'with valid attributes' do
    subject(:bearer) { build :bearer }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:name) }
  end

  context 'with prohibited name' do
    let(:bearer) { build :bearer, name: 'invalid sth' }
    it 'is not valid' do
      expect(bearer).to_not be_valid
    end
  end
end
