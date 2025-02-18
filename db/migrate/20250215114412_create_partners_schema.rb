class CreatePartnersSchema < ActiveRecord::Migration[8.0]
  def change
    enable_extension 'postgis' unless extension_enabled?('postgis')

    create_table :addresses do |t|
      t.st_point :location, geographic: true, null: false

      t.timestamps
    end
    add_index :addresses, :location, using: :gist

    create_table :partners do |t|
      t.string :full_name, null: false
      t.integer :operating_radius, null: false
      t.st_polygon :operating_area, geographic: false, null: false
      t.decimal :rating, precision: 3, scale: 2, null: false, index: true, default: 0.0
      t.references :address, foreign_key: true, null: false, index: true

      t.timestamps
    end
    add_index :partners, :operating_area, using: :gist

    create_table :flooring_materials do |t|
      t.string :name, null: false, index: { unique: true }

      t.timestamps
    end

    # TODO: add id and partner
    create_table :flooring_materials_partners, id: false do |t|
      t.references :partner, null: false, foreign_key: true
      t.references :flooring_material, null: false, foreign_key: true
    end

    add_index :flooring_materials_partners, [ :partner_id, :flooring_material_id ], unique: true
  end
end
