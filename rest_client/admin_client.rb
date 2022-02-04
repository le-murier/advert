#!/usr/bin/env ruby
require 'rubygems'
require 'rest_client'
require 'json'
require_relative 'rest_const'

class AdminClient
  def initialize(token)
    @token = token
    @headers = { "Content-Type" => "application/x-www-form-urlencoded" }
  end

  attr_accessor :token

  def show
    begin
      RestClient::Request.execute(
          method: :get,
          url: ADMINS_URI,
          headers: @headers
      )
    rescue RestClient::ExceptionWithResponse => err
      err.response
    end
  end

  def update_user(id, role)
    begin
      RestClient::Request.execute(
        method: :put,
        url: get_url_user(id),
        payload: { "role": @role },
        headers: @headers
      )
    rescue RestClient::ExceptionWithResponse => err
      err.response
    end
  end

  def delete_user(id)
    begin
      RestClient::Request.execute(
        method: :delete,
        url: get_url_user(id),
        headers: @headers
      )
    rescue RestClient::ExceptionWithResponse => err
      err.response
    end
  end

  def get_drafts
    begin
      RestClient::Request.execute(
        method: :get,
        url: DRAFTS_URI,
        headers: @headers
      )
    rescue RestClient::ExceptionWithResponse => err
      err.response
    end
  end

  def update_advert(id)
    begin
      RestClient::Request.execute(
        method: :put,
        url: get_url_advert(id),
        payload: { "status": @status },
        headers: @headers
      )
    rescue RestClient::ExceptionWithResponse => err
      err.response
    end
  end

  def delete_advert(id)
    begin
      RestClient::Request.execute(
        method: :delete,
        url: get_url_advert(id),
        headers: @headers
      )
    rescue RestClient::ExceptionWithResponse => err
      err.response
    end
  end

  def delete_comment(id)
    begin
      RestClient::Request.execute(
        method: :delete,
        url: get_url_comment(id),
        headers: @headers
      )
    rescue RestClient::ExceptionWithResponse => err
      err.response
    end
  end

  def refresh_headers
    @headers = { "Content-Type" => "application/x-www-form-urlencoded",
        "Authorization": "Bearer #{@token}"}
  end

  private

  def get_url_user(id)
    USERS_URI + id.to_s
  end

  def get_url_advert(id)
    ADVERTS_URI + id.to_s
  end

  def get_url_comment(id)
    COMMENTS_URI + id.to_s
  end
end
