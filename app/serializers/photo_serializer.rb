class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :name, :updated_at

  def updated_at
    object.updated_at.to_date
  end

  def image_data
    # Rails.application.routes.url_helpers.url_for(image_data) if image_data.attached?
  end
end
