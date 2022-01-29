class CommentSerializer < ActiveModel::Serializer
  attributes :username, :content
  def username
    self.object.user.user_name
  end
end
