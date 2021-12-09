module Users
  class RegistrationsController < Devise::RegistrationsController
    respond_to :json

    private

    def respond_with(_resource, _opts = {})
      if current_user
        render json: { user: current_user, token: current_token }, status: :ok
      else
        render json: { error: @user.errors.full_messages }, status: 422
      end
    end

    def current_token
      request.env['warden-jwt_auth.token']
    end
  end
end
