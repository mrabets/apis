require "bunny"

module Likes
  class PusherService
    def initialize(photo_id, user)
      @photo_id = photo_id
      @user = user
    end

    def create
      raise CustomError.new(422), 'Like already liked' if already_like?

      redis.hset('likes', redis_like_key, true)

      photo.increment!(:likes_count)
    end

    def destroy
      raise CustomError.new(422), 'Like already unliked' unless already_like?

      redis.hset('likes', redis_like_key, false)

      photo.decrement!(:likes_count)
    end

    def already_like?
      liked = redis.hget('likes', redis_like_key)

      return true if liked == 'true'
      return false if liked == 'false'

      like.try(:liked)
    end

    private

    attr_reader :photo_id, :user

    def like
      @like = Like.find_by(user: user, photo: photo)
    end

    def photo
      @photo ||= Photo.find(photo_id)
    end

    def redis
      @redis ||= Redis.new(host: ENV.fetch('REDIS_HOST'))
    end

    def redis_like_key
      @redis_like_key ||= "#{photo_id}---#{user.id}"
    end
  end
end
