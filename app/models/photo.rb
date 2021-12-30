class Photo < ApplicationRecord
  has_one_attached :image, service: :google
  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :name, presence: true, length: { in: 1..255 }
end
