module Likes
  class PusherService
    attr_reader :photo_id, :user

    def initialize(photo_id, user)
      @photo_id = photo_id
      @user = user
    end

    def create
      like_create if like.nil?

      raise StandardError, 'Like already liked' if already_like?

      redis.set(redis_key, true) if toggle_like(true)

      like
    end

    def destroy
      raise StandardError, 'Like already unliked' unless already_like?

      redis.set(redis_key, false) if toggle_like(false)
    end

    private

    def toggle_like(liked)
      Like.where(user: user, photo: photo, liked: !liked).update_all(liked: liked)
    end

    def like
      @like ||= Like.find_by(user: user, photo: photo)
    end

    def like_create
      photo.likes.create(user_id: user.id, liked: true)
      redis.set(redis_key, true)
    end

    def already_like?
      redis.get(redis_key) == 'true' || like.try(:liked?)
    end

    def photo
      @photo ||= Photo.find(photo_id)
    end

    def redis
      @redis ||= Redis.new(host: Rails.application.credentials.dig(:development, :likes_redis_host))
    end

    def redis_key
      "#{photo.id}---#{user.id}"
    end
  end
end
