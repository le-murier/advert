class Comment < ApplicationRecord
  validates :advertisement_id, numericality: { only_integer: true }
  validates :content, length: { in: 10..100 }
  belongs_to :advertisement
  belongs_to :user
end
