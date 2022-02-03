BASE_URI = 'http://localhost:3000'

module Url
  ADVERTS = "#{BASE_URI}/advertisements/"
  DRAFTS = "#{BASE_URI}/advertisements/drafts"
  ADMINS = "#{BASE_URI}/admins"
  USERS = "#{BASE_URI}/users/"
  LOGIN = "#{BASE_URI}/login"
  LOGOUT = "#{BASE_URI}/log_out"
  COMMENTS = "#{BASE_URI}/comments/"
end

module Action
  CREATE = 1
  LOGIN = 2
end
