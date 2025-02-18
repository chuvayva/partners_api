class FlooringMaterial < ApplicationRecord
  include RansackableMaterial

  has_many :flooring_materials_partners, dependent: :destroy
  has_many :partners, through: :flooring_materials_partners
end
