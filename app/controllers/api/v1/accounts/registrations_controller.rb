module Api
  module V1
    module Accounts
      class RegistrationsController < Devise::RegistrationsController
        respond_to :json

        private

        def respond_with(_resource, _opts = {})
          Users::CheckerService.call(@user)

          render json: { user: current_user, token: current_token }, status: :ok
        end

        def current_token
          request.env['warden-jwt_auth.token']
        end
      end
    end
  end
end
