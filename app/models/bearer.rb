class Bearer < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: true

end
