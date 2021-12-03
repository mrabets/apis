class User < ApplicationRecord
  has_secure_password
  has_many :photos, dependent: :destroy

  validates :username, presence: true, uniqueness: true, length: { minimum: 3 }
end
