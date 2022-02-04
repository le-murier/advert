#!/usr/bin/env ruby
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
    begin
      RestClient::Request.execute(
        method: :get,
        url: USERS_URI,
        headers: @headers
      )
    rescue RestClient::ExceptionWithResponse => err
      err.response
    end
  end

  def get_by(id)
    begin
      RestClient::Request.execute(
        method: :get,
        url: get_url_id(id),
        headers: @headers
      )
    rescue RestClient::ExceptionWithResponse => err
      err.response
    end
  end

  def create
    begin
      @response = RestClient::Request.execute(
        method: :post,
        url: USERS_URI,
        payload: get_json(Action::CREATE),
        headers: @headers
      )
    rescue RestClient::ExceptionWithResponse => err
      err.response
    end
  end

  def login
    begin
      @response = RestClient::Request.execute(
        method: :post,
        url: LOGIN_URI,
        payload: get_json(Action::LOGIN),
        headers: @headers
      )
      @token = JSON.parse(@response)["token"]
      @id = JSON.parse(@response)["id"]
      refresh_headers
      @token
    rescue RestClient::ExceptionWithResponse => err
      err.response
    end
  end

  def update(user_name, email, password)
    begin
      RestClient::Request.execute(
        method: :put,
        url: get_url_id(@id),
        payload: get_update_json(user_name, email, password),
        headers: @headers
      )
    rescue RestClient::ExceptionWithResponse => err
      err.response
    end
  end

  def delete(id)
    begin
      RestClient::Request.execute(
        method: :delete,
        url: get_url_id(id),
        headers: @headers
      )
    rescue RestClient::ExceptionWithResponse => err
      err.response
    end
  end

  def logout
    begin
      RestClient::Request.execute(
        method: :post,
        url: LOGOUT_URI,
        headers: @headers
      )
    rescue RestClient::ExceptionWithResponse => err
      err.response
    end
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
    else
      params = { }
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
    USERS_URI + id.to_s
  end

  def refresh_headers
    @headers = { "Content-Type" => "application/x-www-form-urlencoded",
        "Authorization": "Bearer #{@token}"}
  end
end
