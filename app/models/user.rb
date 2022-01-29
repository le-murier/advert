  class User < ApplicationRecord
  has_secure_password
  has_many :advertisements
  validates :user_name, :email,  uniqueness: { case_sensitive: false }
end
