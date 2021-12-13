class AuthenticationError < StandardError
  attr_reader :status

  def initialize(status)    
    super
    @status = status
  end
end