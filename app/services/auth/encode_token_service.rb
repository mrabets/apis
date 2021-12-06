module Auth
  class EncodeTokenService
    def initialize(payload:)
      @payload = payload
    end

    def call
      JWT.encode(
        @payload, 
        Rails.application.credentials.dig(:development, :jwt_secret_key)
      )
    end
  end
end
