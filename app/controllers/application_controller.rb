class ApplicationController < ActionController::API
  before_action :set_default_url_options

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  private

  def set_default_url_options
    Rails.application.routes.default_url_options[:host] = request.base_url
  end

  def render_not_found(exception)
    render json: {
      errors: [
        {
          status: "404",
          title: "Not Found",
          detail: exception.message
        }
      ]
    }, status: :not_found
  end
end
