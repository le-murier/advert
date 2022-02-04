#!/usr/bin/env ruby
require 'rubygems'
require 'rest_client'
require 'json'
require_relative 'rest_const'

class CommentClient
  def initialize(adverb_id, content)
    @token = " "
    @id = -1
    @adverb_id = adverb_id
    @content = content
    @headers = { "Content-Type" => "application/x-www-form-urlencoded",
        "Authorization": "Bearer #{@token}"}
  end

  attr_accessor :token, :id

  def get_by(id)
    begin
      RestClient::Request.execute(
        method: :get,
        url: get_url_by(id),
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
        url: COMMENTS_URI,
        payload: get_json,
        headers: @headers
      )
      @id = JSON.parse(@response)["id"]
      @response
    rescue RestClient::ExceptionWithResponse => err
      err.response
    end
  end

  def update(id, content)
    begin
      RestClient::Request.execute(
        method: :put,
        url: get_url_by(id),
        payload: { "content": content },
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
        url: get_url_by(id),
        headers: @headers
      )
    rescue RestClient::ExceptionWithResponse => err
      err.response
    end
  end

  private

  def get_json
    params = {
        "adverb_id": @adverb_id,
        "content": @content,
      }
  end

  def get_url_by(id)
    COMMENTS_URI + id.to_s
  end

  def refresh_headers
    @headers = { "Content-Type" => "application/x-www-form-urlencoded",
        "Authorization": "Bearer #{@token}"}
  end
end
