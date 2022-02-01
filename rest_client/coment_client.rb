require 'rubygems'
require 'rest_client'
require 'json'

BASE_URI = 'http://localhost:3000'

module Action
  CREATE = 1
  UPDATE = 2
end

module Url
  COMMENTS = "#{BASE_URI}/comments"
end

class CommentClient
  def initialize(adverb_id, content)
    @token = " "
    @adverb_id = adverb_id
    @content = content
    @headers = { "Content-Type" => "application/x-www-form-urlencoded" }
  end

  def GetCommentByIg(id)
    RestClient::Request.execute(
      method: :get,
      url: GetUrlId(id),
      payload: { "id": id },
      token: @token,
      headers: @headers
    )
  end

  def CreateComment
    RestClient::Request.execute(
      method: :post,
      url: Url::COMMENTS,
      payload: GetJson(Action::CREATE),
      headers: @headers
    )
  end

  def UpdateComment(id)
    RestClient::Request.execute(
      method: :put,
      url: GetUrlId(id),
      payload: GetJson(Action::UPDATE),
      token: @token,
      headers: @headers
    )
  end

  def DeleteComment(id)
    RestClient::Request.execute(
      method: :delete,
      url: GetUrlId(id),
      token: @token,
      headers: @headers
    )
  end

  private

  def GetJson(action)
    case action
    when Action::CREATE
      params = {
        "adverb_id": @adverb_id,
        "content": @content,
      }
    when Action::UPDATE
      params = {
        "content": @content,
      }
    end
  end

  def GetUrlId(id)
    Url::COMMENTS + id.to_s
  end
end
