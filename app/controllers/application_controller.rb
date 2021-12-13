class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  rescue_from StandardError, with: :render_json_error
  rescue_from AuthenticationError, with: :render_json_error_with_status

  private

  def render_json_error(error)
    render json: { error: error }, status: status
  end

  def render_json_error_with_status(error)
    render json: { error: error.message }, status: error.status
  end
end
