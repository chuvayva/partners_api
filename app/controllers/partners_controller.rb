class PartnersController < ApplicationController
  before_action :set_partner, only: [ :show ]

  def show
    render json: PartnerSerializer.new(@partner, include: [ :address, :flooring_materials ]).serializable_hash
  end

  private

  def set_partner
    @partner = Partner.find(params.require(:id))
  end
end
