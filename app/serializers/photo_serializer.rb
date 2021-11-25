class PhotoSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :updated_at, :image

  def updated_at
    object.updated_at.to_date
  end

  def image
   rails_blob_path(object.image_data, only_path: true) if object.image_data.attached?
  end
end
