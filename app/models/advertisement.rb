class Advertisement < ApplicationRecord
  belongs_to :user
  has_many :comment
  has_many :view
  validates :title, uniqueness: { case_sensitive: false }
  validates :content, length: { in: 10..300 }
end
