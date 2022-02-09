class Advertisement < ApplicationRecord
  validates :title, uniqueness: { case_sensitive: false }
  validates :content, length: { in: 10..300 }
  belongs_to :user
  has_many :comments
  has_many :views
end
