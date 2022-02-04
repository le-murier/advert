BASE_URI = 'http://localhost:3000'
ADVERTS_URI = "#{BASE_URI}/advertisements/"
DRAFTS_URI = "#{BASE_URI}/advertisements/drafts"
ADMINS_URI = "#{BASE_URI}/admins"
USERS_URI = "#{BASE_URI}/users/"
LOGIN_URI = "#{BASE_URI}/login"
LOGOUT_URI = "#{BASE_URI}/log_out"
COMMENTS_URI = "#{BASE_URI}/comments/"

module Action
  CREATE = 1
  LOGIN = 2
end
