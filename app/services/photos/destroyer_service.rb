module Photos
  class DestroyerService
    def initialize(photo_id, user)
      @user = user
      @photo_id = photo_id
    end

    def destroy
      raise CustomError.new(422), 'Photo not found' if photo.nil?
      raise CustomError.new(422), 'Cannot delete from this user' unless belongs_to_user?

      Photo.destroy(photo_id)
    end

    private

    attr_reader :user, :photo_id

    def belongs_to_user?
      @user.id == photo.user_id
    end

    def photo
      @photo ||= Photo.where(id: @photo_id)[0]
    end
  end
end
