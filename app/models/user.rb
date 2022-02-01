  class User < ApplicationRecord
  has_secure_password
  @REGEX_EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/
  @REGEX_PASSWORD = /\A(?=.*[a-zA-Z])(?=.*[0-9]).{6,}\z/
  @REGEX_USERNAME = /\A[a-z0-9_-]{3,15}\z/
  has_many :advertisements
  validates :user_name, :email,  uniqueness: { case_sensitive: false }
  validates :user_name, format: { with: @REGEX_USERNAME }
  validates :email, format: { with: @REGEX_EMAIL }
#  validates :password, format: { with: @REGEX_PASSWORD }
end
