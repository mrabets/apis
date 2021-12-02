module Likes
  class DestroyerService
    def initialize(like:, photo:, user:)
      @like = like
      @photo = photo
      @user = user
    end

    def destroy()
      return false unless @like

      @like.liked = false
      @like.save

      Redis.new.set("#{@photo.id}---#{@user.id}", false)
    end
  end
end
