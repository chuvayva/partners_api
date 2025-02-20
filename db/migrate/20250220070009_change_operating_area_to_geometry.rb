class ChangeOperatingAreaToGeometry < ActiveRecord::Migration[8.0]
  def up
    remove_index :partners, :operating_area
    remove_column :partners, :operating_area

    add_column :partners, :operating_area, :geometry, limit: { srid: 4326, type: "geometry" }
    add_index :partners, :operating_area, using: :gist

    execute <<-SQL.squish
      UPDATE partners
      SET operating_area = ST_Buffer(
          ST_SetSRID(
            ST_MakePoint(
                ST_X(addresses.location::geometry),
                ST_Y(addresses.location::geometry)
            ),
            4326
          ),
          operating_radius
        )
        FROM addresses
        WHERE partners.address_id = addresses.id;
      SQL

    change_column_null :partners, :operating_area, false
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "This migration cannot be reversed"
  end
end
