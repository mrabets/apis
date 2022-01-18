require "bunny"

module Users
  class ProfileService
    def initialize(action, country)
      @action = action
      @country = country
    end

    def send_stats
      connection = Bunny.new
      connection.start

      channel = connection.create_channel

      queue = channel.queue "dev-queue"

      exchange = channel.default_exchange

      exchange.publish(visit_data, routing_key: "dev-queue")

      sleep 1

      connection.close
    end

    private

    attr_reader :action, :country   

    def visit_data
      {
        visit_at: Time.current,
        action: @action,
        country: @country
      }
      .to_json
    end
  end
end