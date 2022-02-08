class SendVisitsJob < ApplicationJob
  queue_as :default

  def perform(action, country)
    Users::ProfileService.new(action, country).send_stats
  end
  
end
