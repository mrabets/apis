class AddLikesCountToPhotos < ActiveRecord::Migration[6.1]
  def change
    add_column :photos, :likes_count, :integer, default: 0

    Photo.reset_column_information
    Photo.all.each do |p|
      Photo.update_counters p.id, likes_count: Photo.joins(:likes).where('photos.id = ? AND likes.liked = ?', p.id, true).count
    end
  end
end
