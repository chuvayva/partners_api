require "rails_helper"

RSpec.describe "POST /partners/search", type: :request do
  subject(:post_search) { post search_partners_path, params: { filter:, page: }, as: :json }
  let(:filter) { {} }
  let(:page) { {} }

  let(:wood) { create :flooring_material, name: "Wood" }
  let(:carpet) { create :flooring_material, name: "Carpet" }
  let(:tiles) { create :flooring_material, name: "Tiles" }

  context "with flooring_materials filter" do
    let(:filter) { { flooring_materials: [ wood.id, carpet.id ] } }

    let!(:partner_1) { create :partner, rating: 5, flooring_materials: [ wood ] }
    let!(:partner_2) { create :partner, rating: 4, flooring_materials: [ wood, carpet ] }
    let!(:partner_3) { create :partner, rating: 3, flooring_materials: [ wood, carpet, tiles ] }

    it "returns partner_2 and partner_3" do
      post_search

      expect(response.body).to include_json(search_partners_json([ partner_2, partner_3 ]))
    end
  end

  context "with location filter" do
    let(:filter) { { location: { latitude:, longitude: } } }
    let(:latitude) { build(:address, :in_berlin).location.latitude }
    let(:longitude) { build(:address, :in_berlin).location.longitude }

    let!(:partner_1) { create :partner, :in_7000_from_berlin, operating_radius: 5_000 }
    let!(:partner_2) { create :partner, :in_3000_from_berlin, operating_radius: 5_000 }

    it "returns partner_2" do
      post_search

      expect(response.body).to include_json(search_partners_json([ partner_2 ]))
    end
  end

  context "with pagination params" do
    let(:page) { { number: 2, size: 2 } }

    let!(:partner_1) { create :partner, rating: 5 }
    let!(:partner_2) { create :partner, rating: 4 }
    let!(:partner_3) { create :partner, rating: 3 }

    it "returns partner_3" do
      post_search

      expected_pagination = { current_page: 2, per_page: 2, total_pages: 2, total_records: 3 }
      expect(response.body).to include_json(search_partners_json([ partner_3 ], **expected_pagination))
    end
  end

  context "with all filters and params" do
    let(:filter) { { flooring_materials: [ tiles.id, carpet.id ], location: { latitude:, longitude: } } }
    let(:page) { { number: 2, size: 2 } }

    let(:latitude) { build(:address, :in_berlin).location.latitude }
    let(:longitude) { build(:address, :in_berlin).location.longitude }

    let!(:partner_1) { create :partner, :in_7000_from_berlin, flooring_materials: [ carpet, tiles ], rating: 5 }
    let!(:partner_2) { create :partner, :in_3000_from_berlin, flooring_materials: [ wood, carpet ], rating: 5  }
    let!(:partner_3) { create :partner, :in_berlin, flooring_materials: [ carpet, tiles ], rating: 5  } # 1-1
    let!(:partner_4) { create :partner, :in_berlin, flooring_materials: [ carpet, tiles ], rating: 4  } # 1-2
    let!(:partner_5) { create :partner, :in_3000_from_berlin, flooring_materials: [ carpet, tiles ], rating: 4  } # 2-1
    let!(:partner_6) { create :partner, :in_berlin, flooring_materials: [ carpet, wood, tiles ], rating: 3  }  # 2-2
    let!(:partner_7) { create :partner, :in_3000_from_berlin, flooring_materials: [ wood, carpet ], rating: 5  }
    let!(:partner_8) { create :partner, :in_7000_from_berlin, flooring_materials: [ wood, tiles ], rating: 5  }
    let!(:partner_9) { create :partner, rating: 5 }

    it "returns partner_5 and partner_6" do
      post_search

      expected_pagination = { current_page: 2, per_page: 2, total_pages: 2, total_records: 4 }
      expect(response.body).to include_json(search_partners_json([ partner_5, partner_6 ], **expected_pagination))
    end
  end
end
