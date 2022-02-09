class AdvertisementSerializer < ActiveModel::Serializer
  attributes :title, :username, :views_number
  def username
    self.object.user.user_name
  end
end
