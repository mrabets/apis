task save_likes_to_database: :environment do
  likes = redis.hgetall 'likes'

  unless likes.empty?
    likes.each do |key, liked|
      photo_id, user_id = key.split '---'

      like = Like.where(photo_id: photo_id, user_id: user_id)

      if like.empty?
        Like.create!(
          photo_id: photo_id,
          user_id: user_id,
          liked: liked
        )
      else
        like.update_all(liked: liked)
      end
    end

    redis.flushall

    puts 'Likes created'
  end
end

def redis
  @redis ||= Redis.new(host: ENV.fetch('REDIS_HOST'))
end
