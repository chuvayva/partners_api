# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_02_20_070009) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "postgis"

  create_table "addresses", force: :cascade do |t|
    t.geography "location", limit: {srid: 4326, type: "st_point", geographic: true}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location"], name: "index_addresses_on_location", using: :gist
  end

  create_table "flooring_materials", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_flooring_materials_on_name", unique: true
  end

  create_table "flooring_materials_partners", id: false, force: :cascade do |t|
    t.bigint "partner_id", null: false
    t.bigint "flooring_material_id", null: false
    t.index ["flooring_material_id"], name: "index_flooring_materials_partners_on_flooring_material_id"
    t.index ["partner_id", "flooring_material_id"], name: "idx_on_partner_id_flooring_material_id_07fc233101", unique: true
    t.index ["partner_id"], name: "index_flooring_materials_partners_on_partner_id"
  end

  create_table "partners", force: :cascade do |t|
    t.string "full_name", null: false
    t.integer "operating_radius", null: false
    t.decimal "rating", precision: 3, scale: 2, default: "0.0", null: false
    t.bigint "address_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.geometry "operating_area", limit: {srid: 4326, type: "geometry"}, null: false
    t.index ["address_id"], name: "index_partners_on_address_id"
    t.index ["operating_area"], name: "index_partners_on_operating_area", using: :gist
    t.index ["rating"], name: "index_partners_on_rating"
  end

  add_foreign_key "flooring_materials_partners", "flooring_materials"
  add_foreign_key "flooring_materials_partners", "partners"
  add_foreign_key "partners", "addresses"
end
