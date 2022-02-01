require 'rubygems'
require 'rest_client'
require 'json'

BASE_URI = 'http://localhost:3000'

module Url
  ADVERTS = "#{BASE_URI}/advertisements/"
  DRAFTS = "#{BASE_URI}/drafts"
end

class AdvertClient
  def initialize(title, content)
    @token = " "
    @title = title
    @content = content
    @headers = { "Content-Type" => "application/x-www-form-urlencoded" }
  end

  def GetAdverts
    RestClient.get(Url::ADVERTS)
  end

  def GetAdvertByIg(id)
    RestClient::Request.execute(
      method: :get,
      url: GetUrlId(id),
      payload: { "id": id },
      token: @token,
      headers: @headers
    )
  end

  def GetDrafts
    RestClient::Request.execute(
      method: :get,
      url: Url::DRAFTS,
      token: @token,
      headers: @headers
    )
  end

  def CreateAdvert
    RestClient::Request.execute(
      method: :post,
      url: Url::ADVERTS,
      payload: GetJson(),
      headers: @headers
    )
  end

  def UpdateAdvert(id)
    RestClient::Request.execute(
      method: :put,
      url: GetUrlId(id),
      payload: GetJson(),
      headers: @headers
    )
  end

  def DeleteUser(id)
    RestClient::Request.execute(
      method: :delete,
      url: GetUrlId(id),
      payload: GetJson(),
      headers: @headers
    )
  end

  def ShowAdvertComment(id)
    RestClient::Request.execute(
      method: :get,
      url: UrlComment(id),
      token: @token,
      headers: @headers
    )
  end

  private

  def GetJson()
      params = {
        "title": @user_name,
        "content": @email,
      }
  end

  def GetUrlId(id)
    Url::ADVERTS + id.to_s
  end

  def UrlComment(id)
    GetUrlId(id) + "/comments"
  end
end
