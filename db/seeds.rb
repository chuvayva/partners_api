require 'rgeo'

# Create Flooring Materials
carpet = FlooringMaterial.find_or_create_by!(name: "Carpet")
tiles = FlooringMaterial.find_or_create_by!(name: "Tiles")
wood = FlooringMaterial.find_or_create_by!(name: "Wood")

# Helper function to create addresses
def create_address(latitude, longitude)
  geo_factory = RGeo::Geographic.spherical_factory(srid: 4326)
  Address.create!(location: geo_factory.point(longitude, latitude))
end

# Berlin and surrounding locations
def create_berlin_address
  create_address(52.5163, 13.3777)
end

def create_near_3000_address
  create_address(52.5354, 13.4090)
end

def create_near_7000_address
  create_address(52.5608, 13.4507)
end

def create_partner(**attrs)
  partner = Partner.new(attrs)
  partner.operating_area = GeoHelper.operating_area(partner.address, partner.operating_radius)
  partner.save!
end

# Create Partners
[
  { full_name: Faker::Name.name, address: create_near_7000_address, flooring_materials: [ carpet, tiles ], rating: 5,
    operating_radius: 5_000 },
  { full_name: Faker::Name.name, address: create_near_3000_address, flooring_materials: [ wood, carpet ], rating: 5,
    operating_radius: 5_000 },
  { full_name: Faker::Name.name, address: create_berlin_address, flooring_materials: [ carpet, tiles ], rating: 5,
    operating_radius: 5_000 },
  { full_name: Faker::Name.name, address: create_berlin_address, flooring_materials: [ carpet, tiles ], rating: 4,
    operating_radius: 5_000 },
  { full_name: Faker::Name.name, address: create_near_3000_address, flooring_materials: [ carpet, tiles ], rating: 4,
    operating_radius: 5_000 },
  { full_name: Faker::Name.name, address: create_berlin_address, flooring_materials: [ carpet, wood, tiles ], rating: 3,
    operating_radius: 5_000 },
  { full_name: Faker::Name.name, address: create_near_3000_address, flooring_materials: [ wood, carpet ], rating: 5,
    operating_radius: 5_000 },
  { full_name: Faker::Name.name, address: create_near_7000_address, flooring_materials: [ wood, tiles ], rating: 5,
    operating_radius: 5_000 }
].each { create_partner(**_1) }

puts "✅ Seeded 9 partners"
