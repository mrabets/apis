module Likes
  class PusherService
    def initialize(photo_id, user)
      @photo_id = photo_id
      @user = user
    end

    def create
      first_create = false

      if like.nil?
        like_create
        first_create = true
      else
        raise CustomError.new(422), 'Like already liked' if already_like?
      end

      redis.set(redis_key, true) if toggle_like(true)

      toggle_like_count(true) unless first_create

      like
    end

    def destroy
      raise CustomError.new(422), 'Like already unliked' unless already_like?

      redis.set(redis_key, false) if toggle_like(false)

      toggle_like_count(false)
    end

    def already_like?
      redis.get(redis_key) == 'true' || like.try(:liked?) || false
    end

    private

    attr_reader :photo_id, :user

    def toggle_like(liked)
      Like.where(user: user, photo: photo, liked: !liked).update_all(
        liked: liked
      )
    end

    def toggle_like_count(liked)
      liked ? photo.increment!(:likes_count) : photo.decrement!(:likes_count)
    end

    def like
      @like = Like.find_by(user: user, photo: photo)
    end

    def like_create
      photo.likes.create(user_id: user.id, liked: true)
      redis.set(redis_key, true)
    end 

    def photo
      @photo ||= Photo.find(photo_id)
    end

    def redis
      @redis ||= Redis.new(host: ENV.fetch("REDIS_HOST"))
    end

    def redis_key
      "#{photo.id}---#{user.id}"
    end
  end
end
