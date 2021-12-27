class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  rescue_from CustomError, with: :render_json_error_with_status

  private

  def render_json_error_with_status(error)
    render json: { error: error.message }, status: error.status
  end
end
