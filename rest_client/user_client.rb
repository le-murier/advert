require 'rubygems'
require 'rest_client'
require 'json'

BASE_URI = 'http://localhost:3000'

module Action
  CREATE = 1
  LOGIN = 2
  UPDATE = 3
end

module Url
  ADMINS = "#{BASE_URI}/users/admins"
  USERS = "#{BASE_URI}/users/"
  LOGIN = "#{BASE_URI}/login"
  LOGOUT = "#{BASE_URI}/log_out"
end

class UserClient
  @@url = Url::USERS
  def initialize(user_name, email, password)
    @token = " "
    @user_name = user_name
    @email = email
    @password = password
    @headers = { "Content-Type" => "application/x-www-form-urlencoded" }
  end

  def GetUser
    RestClient.get(@@url)
  end

  def GetUserByIg(id)
    RestClient::Request.execute(
      method: :get,
      url: GetUrlId(id),
      payload: { "id": id },
      token: @token,
      headers: @headers
    )
  end

  def GetAdmins
    RestClient::Request.execute(
      method: :get,
      url: Url::ADMINS,
      token: @token,
      headers: @headers
    )
  end

  def CreateUser
    RestClient::Request.execute(
      method: :post,
      url: Url::USERS,
      payload: GetJson(Action::CREATE),
      headers: @headers
    )
  end

  def Login
    @response = RestClient::Request.execute(
      method: :post,
      url: Url::LOGIN,
      payload: GetJson(Action::LOGIN),
      headers: @headers
    )
    @token = JSON.parse(@response)["token"]
  end

  def UpdateUser(id)
    RestClient::Request.execute(
      method: :put,
      url: GetUrlId(id),
      payload: GetJson(Action::UPDATE),
      token: @token,
      headers: @headers
    )
  end

  def DeleteUser(id)
    RestClient::Request.execute(
      method: :delete,
      url: GetUrlId(id),
      token: @token,
      headers: @headers
    )
  end

  def LogoutUser(id)
    RestClient::Request.execute(
      method: :post,
      url: Url::LOGOUT,
      token: @token,
      headers: @headers
    )
  end

  private

  def GetJson(action)
    case action
    when Action::CREATE || Action::UPDATE
      params = {
        "user_name": @user_name,
        "email": @email,
        "password": @password
      }
    when Action::LOGIN
      params = {
        "user_name": @user_name,
        "password": @password
      }
    end
  end

  def GetUrlId(id)
    Url::USERS + id.to_s
  end
end
