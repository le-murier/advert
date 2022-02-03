require 'rubygems'
require 'rest_client'
require 'json'
require_relative  'rest_const'

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
    RestClient::Request.execute(
      method: :get,
      url: get_url_by(id),
      headers: @headers
    )
  end

  def create
    refresh_headers()
    @response = RestClient::Request.execute(
      method: :post,
      url: Url::COMMENTS,
      payload: get_json(),
      headers: @headers
    )
    @id = JSON.parse(@response)["id"]
    @response
  end

  def update(id, content)
    RestClient::Request.execute(
      method: :put,
      url: get_url_by(id),
      payload: { "content": content },
      headers: @headers
    )
  end

  def delete(id)
    RestClient::Request.execute(
      method: :delete,
      url: get_url_by(id),
      headers: @headers
    )
  end

  private

  def get_json()
      params = {
        "adverb_id": @adverb_id,
        "content": @content,
      }
  end

  def get_url_by(id)
    Url::COMMENTS + id.to_s
  end

  def refresh_headers
    @headers = { "Content-Type" => "application/x-www-form-urlencoded",
        "Authorization": "Bearer #{@token}"}
  end
end
