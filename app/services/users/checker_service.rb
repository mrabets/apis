module Users
  class CheckerService
    def self.call(user)      
      raise AuthenticationError.new(422), user.errors.full_messages.join(" ") unless user.try(:id)
    end
  end
end