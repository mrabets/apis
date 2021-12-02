module Likes
  class UpdaterService
    def initialize(like:)
      @like = like
    end

    def update
      @like.liked = true
      @like.save
    end
  end
end