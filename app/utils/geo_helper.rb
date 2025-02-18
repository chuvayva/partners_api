module GeoHelper
  class << self
    def operating_area(address, operating_radius)
      factory = RGeo::Geographic.spherical_factory(srid: 4326)
      factory.point(address.location.x, address.location.y).buffer(operating_radius)
    end
  end
end
