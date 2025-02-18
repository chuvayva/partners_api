FactoryBot.define do
  factory :partner do
    full_name { Faker::Name.name }
    operating_radius { 5_000 }

    address

    before(:create) do |partner|
      partner.operating_area = GeoHelper.operating_area(partner.address, partner.operating_radius)
    end

    %i[in_berlin in_3000_from_berlin in_7000_from_berlin].each do |trait_name|
      trait trait_name do
        address { create(:address, trait_name) }
      end
    end
  end
end
