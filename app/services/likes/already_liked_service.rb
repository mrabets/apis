module Likes
  class AlreadyLikedService
    def initialize(like:, photo:, user:)
      @photo = photo
      @user = user
      @like = like
    end

    def call
      return Redis.new.get("#{@photo.id}---#{@user.id}") == "true" || @like.try(:liked?)
            #  @photo.likes.where(user_id: @user.id, photo_id: @photo.id)[0].liked?
    end
  end
end