module Photos
  class DestroyerService
    def self.call(photo_id)
      begin
        Photo.destroy(photo_id)
      rescue ActiveRecord::RecordNotFound
        raise CustomError.new(422), 'Photo not found'
      end
    end
  end
end
