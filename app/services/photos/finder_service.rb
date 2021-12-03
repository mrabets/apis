module Photos
  class FinderService
    def initialize(photo_id:)
      @photo_id = photo_id
    end

    def call
      Photo.find(@photo_id)
    end
  end
end
