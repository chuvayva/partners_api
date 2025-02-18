module JsonHelpers
  def search_partners_json(partners, current_page: 1, per_page: 25, total_pages: 1, total_records: nil)
    {
      meta: {
        pagination: {
          current_page:,
          per_page:,
          total_pages:,
          total_records: total_records || partners.count
        }
      },
      data: partners.map {
        {
          type: "partner",
          id: _1.id.to_s,
          attributes: {
            full_name: _1.full_name,
            operating_radius: _1.operating_radius,
            rating: _1.rating.to_s,
            distance: be_a(Float).or(be_nil)
          },
          links: {
            self: be_a(String)
          }
        }
      }
    }
  end
end
