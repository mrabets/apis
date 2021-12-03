module Likes
  class FinderService
    def initialize(photo:, user:)
      @photo = photo
      @user = user
    end

    def call
      Like.find_by(
        user_id: @user.id,
        photo_id: @photo.id
      )
    end
  end
end
