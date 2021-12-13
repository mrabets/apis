require 'faker'
require 'factory_bot_rails'

module PhotoHelpers
  def create_photo
    FactoryBot.build(:photo,
                      name: Faker::Lorem.word)
  end
end
