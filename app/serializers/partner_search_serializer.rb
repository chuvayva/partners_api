class PartnerSearchSerializer
  include JSONAPI::Serializer

  set_type :partner

  attributes :full_name, :rating, :operating_radius, :distance

  link :self do |partner|
    Rails.application.routes.url_helpers.partner_url(partner)
  end
end
