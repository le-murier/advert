class Comment < ApplicationRecord
  belongs_to :user
  validates :adverb_id, numericality: { only_integer: true }
  validates :content, length: { in: 10..100 }
end
