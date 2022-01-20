require 'bunny'

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

      exchange = channel.default_exchange

      exchange.publish(visit_data, routing_key: QUEUE_NAME)

      sleep 1

      connection.close
    rescue Bunny::Exception => e
      Rails.logger.debug e
    end

    private

    QUEUE_NAME = 'dev-queue'.freeze

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
