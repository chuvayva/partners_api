class Partner < ApplicationRecord
  belongs_to :address
  has_many :flooring_materials_partners, dependent: :destroy
  has_many :flooring_materials, through: :flooring_materials_partners

  validates :full_name, presence: true
  validates :operating_radius, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :operating_area, presence: true
  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
end
