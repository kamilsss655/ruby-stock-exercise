require 'rails_helper'

RSpec.describe Bearer, type: :model do
  subject(:bearer) {build :bearer}
  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:name) }
end
