class User < ApplicationRecord
  has_secure_password
  has_many :photos

  validates :username, :password, presence: true
  validates :username, uniqueness: true
end
