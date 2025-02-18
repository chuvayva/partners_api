class PartnerSearch::Params < Dry::Struct
  class Location < Dry::Struct
    attribute :latitude,  Types::Coercible::Float
    attribute :longitude,  Types::Coercible::Float
  end

  class Filter < Dry::Struct
    attribute? :flooring_materials, Types::Array.of(Types::Integer).optional
    attribute? :location, Location.optional
  end

  class Page < Dry::Struct
    attribute? :number, Types::Integer.optional
    attribute? :size, Types::Integer.optional
  end

  attribute? :filter, Filter.optional
  attribute? :page, Page.optional
end
