class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :name, :updated_at

  def updated_at
    object.updated_at.to_date
  end
end
