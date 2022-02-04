class Advertisement < ApplicationRecord
  belongs_to :user
  validates :title, uniqueness: { case_sensitive: false }
  validates :content, length: { in: 10..300 }
end
