class PartnersController < ApplicationController
  before_action :set_partner, only: [ :show ]

  def search
    permitted_params = params.permit(
      filter: [ { flooring_materials: [] }, { location: [ :latitude, :longitude ] } ],
      page: [ :number, :size ]
    ).to_h

    partners = PartnerSearch.new(permitted_params).call

    render json: PartnerSearchSerializer.new(partners, meta: PaginationMeta.call(partners)).serializable_hash
  end

  def show
    render json: PartnerSerializer.new(@partner, include: [ :address, :flooring_materials ]).serializable_hash
  end

  private

  def set_partner
    @partner = Partner.find(params.require(:id))
  end
end
