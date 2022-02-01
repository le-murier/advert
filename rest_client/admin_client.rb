require 'rubygems'
require 'rest_client'
require 'json'

BASE_URI = 'http://localhost:3000'

module Url
  ADMINS = "#{BASE_URI}/admins"
  USERS = "#{BASE_URI}/users/"
  ADVERTS = "#{BASE_URI}/advertisements/"
  DRAFTS = "#{BASE_URI}/advertisements/drafts"
  COMMENTS = "#{BASE_URI}/comments/"
end

class AdminClient
  def initialize(token)
    @token = token
    @headers = { "Content-Type" => "application/x-www-form-urlencoded" }
  end

  def ShowAdmins
  end

  def DeleteUser
  end

  def GetDrafts
  end

  def UpdateAdvert
  end

  def DeleteAdvert
  end

  def UpdateComment
  end

  def DeleteComment
  end

  private
end
