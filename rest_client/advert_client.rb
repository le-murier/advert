#!/usr/bin/env ruby
require 'rubygems'
require 'rest_client'
require 'json'
require_relative  'rest_const'

class AdvertClient
  def initialize(title, content)
    @id = -1
    @token = " "
    @title = title
    @content = content
    @headers = { "Content-Type" => "application/x-www-form-urlencoded",
        "Authorization": "Bearer #{@token}"}
  end

  attr_accessor :token, :id

  def get
    RestClient.get(Url::ADVERTS)
  end

  def get_by(id)
    RestClient::Request.execute(
      method: :get,
      url: get_url(id),
      headers: @headers
    )
  end

  def create
    refresh_headers
    @response = RestClient::Request.execute(
      method: :post,
      url: Url::ADVERTS,
      payload: get_json(@title, @content),
      headers: @headers
    )
    @id = JSON.parse(@response)["id"]
    @response
  end

  def update(id, title, content)
    RestClient::Request.execute(
      method: :put,
      url: get_url(id),
      payload: get_json(title, content),
      headers: @headers
    )
  end

  def delete(id)
    RestClient::Request.execute(
      method: :delete,
      url: get_url(id),
      headers: @headers
    )
  end

  def show_comment(id)
    RestClient::Request.execute(
      method: :get,
      url: url_comment(id),
      headers: @headers
    )
  end

  private

  def get_json(title, content)
      params = {
        "title": title,
        "content": content,
      }
  end

  def get_url(id)
    Url::ADVERTS + id.to_s
  end

  def url_comment(id)
    get_url(id) + "/comments"
  end

  def refresh_headers
    @headers = { "Content-Type" => "application/x-www-form-urlencoded",
        "Authorization": "Bearer #{@token}"}
  end
end
