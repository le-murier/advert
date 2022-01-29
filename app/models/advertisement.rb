class Advertisement < ApplicationRecord
  belongs_to :user
  has_many :comment
  validates :title, uniqueness: { case_sensitive: false }
end
