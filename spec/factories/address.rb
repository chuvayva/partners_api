FactoryBot.define do
  factory :address do
    location do
      geo_factory = RGeo::Geographic.spherical_factory(srid: 4326)

      latitude = Faker::Address.latitude
      longitude = Faker::Address.longitude

      geo_factory.point(longitude, latitude)
    end

    trait :in_berlin do
      location do
        geo_factory = RGeo::Geographic.spherical_factory(srid: 4326)
        geo_factory.point(13.3777, 52.5163)
      end
    end

    trait :in_3000_from_berlin do
      location do
        geo_factory = RGeo::Geographic.spherical_factory(srid: 4326)
        geo_factory.point(13.4090, 52.5354)
      end
    end

    trait :in_7000_from_berlin do
      location do
        geo_factory = RGeo::Geographic.spherical_factory(srid: 4326)
        geo_factory.point(13.4507, 52.5608)
      end
    end
  end
end
