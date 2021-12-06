class Api::V1::ApplicationController < ActionController::API
  rescue_from StandardError, with: :render_json_error

  before_action :authorized

  def encode_token(payload)
    Auth::EncodeTokenService.new(payload: payload).call
  end

  def decoded_token
    Auth::DecodeTokenService.new(request: request).call
  end

  def logged_in_user
    @user = Auth::LoggedInService.new(decoded_token: decoded_token).call
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
  
  private

  def render_json_error(error)
    render json: { error: error }
  end  
end
