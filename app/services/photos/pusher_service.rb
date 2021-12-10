module Photos
  class PusherService
    attr_reader :params, :user

    def initialize(params, user)
      @params = params
      @user = user
    end

    def create
      new_photo = user.photos.new(name: params[:name], image: params[:image])

      raise StandardError, new_photo.errors.inspect unless new_photo.save

      new_photo
    end

    def update
      raise StandardError, photo.errors.inspect unless photo.update(name: params[:name])

      photo
    end

    private    

    def photo
      @photo = Photo.find(params[:id])
    end
  end
end
