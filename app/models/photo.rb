class Photo < ApplicationRecord
  has_one_attached :image_data
end
