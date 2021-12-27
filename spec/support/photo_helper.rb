require 'faker'
require 'factory_bot_rails'

module PhotoHelpers
  def create_photo(user)
    FactoryBot.create(:photo,
                      name: Faker::Lorem.word,
                      user_id: user.id)
  end

  def build_photo(user)
    FactoryBot.build(:photo,
                      name: Faker::Lorem.word,
                      user_id: user.id)
  end
end
