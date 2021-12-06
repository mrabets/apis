module Auth
  class LoggedInService
    def initialize(decoded_token:)
      @decoded_token = decoded_token
    end

    def call
      return unless @decoded_token

      user_id = @decoded_token[0]['user_id']
      User.find_by(id: user_id)
    end
  end
end
