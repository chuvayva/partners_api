class PartnerSerializer
  include JSONAPI::Serializer

  attributes :full_name, :rating, :operating_radius

  belongs_to :address
  has_many :flooring_materials

  link :self do |partner|
    Rails.application.routes.url_helpers.partner_url(partner)
  end
end
