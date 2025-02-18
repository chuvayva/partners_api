require "rails_helper"

RSpec.describe "GET /partners/:id", type: :request do
  subject(:get_show) { get partner_path(partner), as: :json }

  let(:carpet) { create :flooring_material, name: "Carpet" }
  let(:tiles) { create :flooring_material, name: "Tiles" }

  let(:partner) { create :partner, :in_berlin, flooring_materials: [ carpet, tiles ], rating: 5  }

  it "returns proper json" do
    get_show

    expect(response.body).to include_json(
      data: {
        type: "partner",
        id: partner.id.to_s,
        attributes: {
          full_name: partner.full_name,
          operating_radius: partner.operating_radius,
          rating: partner.rating.to_s
        },
        relationships: {
          address: {
            data: {
              id: partner.address.id.to_s,
              type: "address"
            }
          },
          flooring_materials: {
            data: partner.flooring_materials.map {
              {
                id: be,
                type: 'flooring_material'
              }
            }
          }
        },
        links: {
          self: be_a(String)
        }
      },
      included: match_array([
        {
          id: partner.address.id.to_s,
          type: "address",
          attributes: {
            location: {
              latitude: partner.address.location.latitude,
              longitude: partner.address.location.longitude
            }
          }
        }.deep_stringify_keys,
        *partner.flooring_materials.map {
          {
            id: _1.id.to_s,
            type: "flooring_material",
            attributes: {
              name: _1.name
            }
          }.deep_stringify_keys
        }
      ])
    )
  end

  context 'when id is invalid' do
    subject(:get_show) { get partner_path(-1), as: :json }

    it "returns bad request" do
      get_show

      expect(response).to have_http_status(:not_found)
      expect(response.body).to include_json(
        errors: [ {
          status: "404",
          title: "Not Found",
          detail: be_a(String)
        } ]
      )
    end
  end
end
