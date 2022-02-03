require 'rubygems'
require 'rest_client'
require 'json'
require_relative 'rest_const'

class UserClient
  def initialize(user_name, email, password)
    @id = -1
    @token = " "
    @user_name = user_name
    @email = email
    @password = password
    @headers = { "Content-Type" => "application/x-www-form-urlencoded",
        "Authorization": "Bearer #{@token}"}
  end

  attr_accessor :token, :id

  def get
    RestClient::Request.execute(
      method: :get,
      url: Url::USERS,
      headers: @headers
    )
  end

  def get_by(id)
    RestClient::Request.execute(
      method: :get,
      url: get_url_id(id),
      headers: @headers
    )
  end

  def create
    @response = RestClient::Request.execute(
      method: :post,
      url: Url::USERS,
      payload: get_json(Action::CREATE),
      headers: @headers
    )
  end

  def login
    @response = RestClient::Request.execute(
      method: :post,
      url: Url::LOGIN,
      payload: get_json(Action::LOGIN),
      headers: @headers
    )
    @token = JSON.parse(@response)["token"]
    @id = JSON.parse(@response)["id"]
    refresh_headers()
    return @token
  end

  def update(user_name, email, password)
    RestClient::Request.execute(
      method: :put,
      url: get_url_id(@id),
      payload: get_update_json(user_name, email, password),
      headers: @headers
    )
  end

  def delete(id)
    RestClient::Request.execute(
      method: :delete,
      url: get_url_id(id),
      headers: @headers
    )
  end

  def logout
    RestClient::Request.execute(
      method: :post,
      url: Url::LOGOUT,
      headers: @headers
    )
  end

  private

  def get_json(action)
    case action
    when Action::CREATE
      params = {
        "user_name": @user_name,
        "email": @email,
        "password": @password,
        "role": "user"
      }
    when Action::LOGIN
      params = {
        "user_name": @user_name,
        "password": @password
      }
    end
  end

  def get_update_json(user_name, email, password)
    params = {
      "user_name": @user_name,
      "email": @email,
      "password": @password,
      "role": "user"
    }
  end

  def get_url_id(id)
    Url::USERS + id.to_s
  end

  def refresh_headers
    @headers = { "Content-Type" => "application/x-www-form-urlencoded",
        "Authorization": "Bearer #{@token}"}
  end
end
