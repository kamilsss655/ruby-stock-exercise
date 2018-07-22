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

require 'rails_helper'

RSpec.describe Stock, type: :model do
  context 'with valid attributes' do
    it { should belong_to(:bearer) }
    it { should belong_to(:market_price) }
  end

  context 'with prohibited name' do
    let(:stock) { build :stock, name: 'invalid sth' }
    it 'is not valid' do
      expect(stock).to_not be_valid
    end
  end

  context 'with soft-delete' do
    let(:stock) { create :stock }
    before(:each) do
      stock.soft_delete
    end
    it 'marks record as deleted' do
      expect(stock.deleted_at).to_not be_nil
    end
    it 'is not accessible via default scope' do
      expect{Stock.find(stock.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end
    it 'is accessible via with_deleted scope' do
      expect(Stock.with_deleted.find(stock.id)).to eq(stock)
    end
  end
end
