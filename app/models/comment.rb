class Comment < ApplicationRecord
  belongs_to :user, :advertisement
end
