module Likes
  class CreatorService
    def initialize(photo:, user:)
      @photo = photo
      @user = user
    end

    def create
      @like = @photo.likes.create(user_id: @user.id, liked: true)
      Redis.new.set("#{@photo.id}---#{@user.id}", true)
      @like
    end
  end
end
