# == Schema Information
#
# Table name: bearers
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  # Factories
  factory :bearer do
    name
  end
  factory :bearer_x_1, class: Bearer do
    name 'Bearer name X 1'
  end
  # Sequences
  sequence :name do |n|
    "Bearer name #{n}"
  end
end
