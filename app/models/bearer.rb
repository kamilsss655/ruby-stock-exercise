# == Schema Information
#
# Table name: bearers
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Bearer < ApplicationRecord
  has_many :stocks,
           inverse_of: :bearer

  validates_with ForbiddenNameValidator
  validates :name,
            presence: true,
            uniqueness: true
end
