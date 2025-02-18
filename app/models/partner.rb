class Partner < ApplicationRecord
  include RansackablePartner

  belongs_to :address
  has_many :flooring_materials_partners, dependent: :destroy
  has_many :flooring_materials, through: :flooring_materials_partners

  validates :full_name, presence: true
  validates :operating_radius, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :operating_area, presence: true
  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

  scope :with_distance, ->(latitude, longitude) {
    return select("partners.*, NULL AS distance") if latitude.blank? || longitude.blank?

    joins(:address).
      select(sanitize_sql_array([
        "partners.*, ST_Distance(addresses.location, ST_MakePoint(?, ?)::geography) AS distance",
        longitude, latitude
      ]))
  }
end
