module RansackablePartner
  extend ActiveSupport::Concern

  class_methods do
    def ransackable_attributes(_auth_object = nil)
      []
    end

    def ransackable_scopes(_auth_object = nil)
      %w[in_operating_area with_flooring_materials]
    end
  end

  included do
    scope :in_operating_area, ->(latitude, longitude) {
      where("ST_Intersects(partners.operating_area, ST_MakePoint(:longitude, :latitude)::geography)",
            latitude: latitude, longitude: longitude)
    }

    scope :with_flooring_materials, ->(material_ids) {
      join_sql = FlooringMaterialsPartner
        .where(flooring_material_id: material_ids)
        .group(:partner_id)
        .having("COUNT(*) = ?", material_ids.count)
        .select(:partner_id).to_sql

      joins(<<~SQL.squish)
        INNER JOIN (#{join_sql}) AS filtered_partners ON partners.id = filtered_partners.partner_id
      SQL
    }
  end
end
