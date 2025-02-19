import "@typespec/http";

using TypeSpec.Http;

@service({
  title: "Partners API",
})
namespace PartnerAPI {
  @post
  @route("/partners/search")
  @summary("Search for partners based on filters and pagination")
  op searchPartners(
    @body body?: {
      filter?: Filter;
      page?: Page;
    },
  ): {
    data: PartnerResource[];
    meta: {
      pagination: {
        current_page: int32;
        per_page: int32;
        total_pages: int32;
        total_records: int32;
      };
    };
  };

  @get
  @route("/partners/{id}")
  @summary("Retrieve partner details by ID")
  op getPartner(@path id: string): {
    data: PartnerResource;
    included: (AddressResource | FlooringMaterialResource)[];
  };

  model PartnerResource {
    type: string;
    id: string;
    attributes: PartnerAttributes;
    relationships?: {
      address: { data: ResourceIdentifier };
      flooring_materials: { data: ResourceIdentifier[] };
    };
    links: {
      self: string;
    };
  }

  model PartnerAttributes {
    full_name: string;
    operating_radius: float;
    rating: string;
    distance?: float;
  }

  model AddressResource {
    type: string;
    id: string;
    attributes: {
      location: Location;
    };
  }

  model FlooringMaterialResource {
    type: string;
    id: string;
    attributes: {
      name: string;
    };
  }

  model Location {
    @minValue(-90)
    @maxValue(90)
    latitude: float;

    @minValue(-180)
    @maxValue(180)
    longitude: float;
  }

  model Filter {
    flooring_materials?: int64[];
    location?: Location;
  }

  model Page {
    @minValue(1)
    number?: int32;

    @minValue(1)
    @maxValue(100)
    size?: int32;
  }

  model ResourceIdentifier {
    type: string;
    id: string;
  }
}
