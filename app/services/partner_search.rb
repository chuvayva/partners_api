class PartnerSearch
  def initialize(params)
    @params = PartnerSearch::Params.new(params.deep_symbolize_keys)
  end

  def call
    scope = Partner.ransack(ransack_query).result

    scope = scope.with_distance(@params.filter&.location&.latitude, @params.filter&.location&.longitude)
    scope = scope.order(rating: :desc, distance: :asc)
    scope = scope.page(@params.page&.number).per(@params.page&.size)

    scope
  end

  def ransack_query
    {
      with_flooring_materials: [ @params.filter&.flooring_materials ],
      in_operating_area: @params.filter&.location&.to_h&.values_at(:latitude, :longitude)
    }
  end
end
