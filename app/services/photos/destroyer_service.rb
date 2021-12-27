module Photos
  class DestroyerService
    def initialize(photo_id, user)
      @user = user
      @photo_id = photo_id
    end

    def destroy
      raise CustomError.new(422), 'Cannot delete from this user' unless belongs_to_user
      
      begin
        Photo.destroy(photo_id)
      rescue ActiveRecord::RecordNotFound
        raise CustomError.new(422), 'Photo not found'
      end
    end

    private

    attr_reader :user, :photo_id

    def belongs_to_user
      @user.id == photo.user_id
    end

    def photo
      @photo ||= Photo.find @photo_id
    end
  end
end
