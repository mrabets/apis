module Auth
  class EncodeTokenService
    def initialize(payload:)
      @payload = payload
    end

    def call
      JWT.encode(@payload, 'yourSecret')
    end
  end
end
