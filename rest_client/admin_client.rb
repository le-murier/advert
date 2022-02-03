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
    RestClient::Request.execute(
        method: :get,
        url: Url::ADMINS,
        headers: @headers
      )
  end

  def update_user(id, role)
    RestClient::Request.execute(
      method: :put,
      url: get_url_user(id),
      payload: { "role": @role },
      headers: @headers
    )
  end

  def delete_user(id)
    RestClient::Request.execute(
      method: :delete,
      url: get_url_user(id),
      headers: @headers
    )
  end

  def get_drafts
    RestClient::Request.execute(
      method: :get,
      url: Url::DRAFTS,
      headers: @headers
    )
  end

  def update_advert(id)
    RestClient::Request.execute(
      method: :put,
      url: get_url_advert(id),
      payload: { "status": @status },
      headers: @headers
    )
  end

  def delete_advert(id)
    RestClient::Request.execute(
      method: :delete,
      url: get_url_advert(id),
      headers: @headers
    )
  end

  def delete_comment(id)
    RestClient::Request.execute(
      method: :delete,
      url: get_url_comment(id),
      headers: @headers
    )
  end

  def refresh_headers
    @headers = { "Content-Type" => "application/x-www-form-urlencoded",
        "Authorization": "Bearer #{@token}"}
  end

  private

  def get_url_user(id)
    Url::USERS + id.to_s
  end

  def get_url_advert(id)
    Url::ADVERTS + id.to_s
  end

  def get_url_comment(id)
    Url::COMMENTS + id.to_s
  end
end
