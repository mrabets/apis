class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  rescue_from StandardError, with: :render_json_error

  private

  def render_json_error(error)
    render json: { error: error }
  end
end
