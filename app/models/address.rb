class Address < ApplicationRecord
  has_one :partner

  validates :location, presence: true
end
