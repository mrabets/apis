module Likes
  class AlreadyLikedService
    def initialize(photo:, user:)
      @photo = photo
      @user = user
    end

    def call
      return Redis.new.get("#{@photo.id}---#{@user.id}") == "true" ||
             @photo.likes.where(user_id: @user.id, photo_id: @photo.id)[0].liked?
    end
  end
end