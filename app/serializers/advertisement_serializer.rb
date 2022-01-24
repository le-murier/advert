class AdvertisementSerializer < ActiveModel::Serializer

  attributes :title, :username, :views, :comments
  def username
    self.object.user.user_name
  end
end
