class AddressSerializer
  include JSONAPI::Serializer

  attributes :location

  attribute :location do |object|
    {
      latitude: object.location.latitude,
      longitude: object.location.longitude
    }
  end
end
