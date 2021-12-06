module Auth
  class DecodeTokenService
    def initialize(request:)
      @request = request
    end

    def call
      return unless auth_header

      token = auth_header.split[1]
      begin
        JWT.decode(
          token,
          Rails.application.credentials.dig(:development, :jwt_secret_key),
          true, algorithm: 'HS256'
        )
      rescue JWT::DecodeError
        nil
      end
    end

    private

    def auth_header
      # { Authorization: 'Bearer <token>' }
      @request.headers['Authorization']
    end
  end
end
