#!/usr/bin/env ruby
require 'rubygems'
require 'rest_client'
require 'json'
require_relative 'rest_const'

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
    begin
      RestClient.get(ADVERTS_URI)
    rescue RestClient::ExceptionWithResponse => err
      err.response
    end
  end

  def get_by(id)
    begin
      RestClient::Request.execute(
        method: :get,
        url: get_url(id),
        headers: @headers
      )
    rescue RestClient::ExceptionWithResponse => err
      err.response
    end
  end

  def create
    begin
      refresh_headers
      @response = RestClient::Request.execute(
        method: :post,
        url: ADVERTS_URI,
        payload: get_json(@title, @content),
        headers: @headers
      )
      @id = JSON.parse(@response)["id"]
      @response
    rescue RestClient::ExceptionWithResponse => err
      err.response
    end
  end

  def update(id, title, content)
    begin
      RestClient::Request.execute(
        method: :put,
        url: get_url(id),
        payload: get_json(title, content),
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
        url: get_url(id),
        headers: @headers
      )
    rescue RestClient::ExceptionWithResponse => err
      err.response
    end
  end

  def show_comment(id)
    begin
      RestClient::Request.execute(
        method: :get,
        url: url_comment(id),
        headers: @headers
      )
    rescue RestClient::ExceptionWithResponse => err
      err.response
    end
  end

  private

  def get_json(title, content)
      params = {
        "title": title,
        "content": content,
      }
  end

  def get_url(id)
    ADVERTS_URI + id.to_s
  end

  def url_comment(id)
    get_url(id) + "/comments"
  end

  def refresh_headers
    @headers = { "Content-Type" => "application/x-www-form-urlencoded",
        "Authorization": "Bearer #{@token}"}
  end
end
