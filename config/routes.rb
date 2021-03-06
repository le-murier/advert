Rails.application.routes.draw do

  get '/users', to: 'users#show'
  get '/users/:id', to: 'users#show_id'
  get '/admins', to: 'users#show_admins'
  post '/users', to: 'users#create'
  post '/login', to: 'users#login'
  put '/users/:id', to: 'users#update'
  delete '/users/:id', to: 'users#delete'
  post '/log_out', to: 'users#log_out'
  #
  get '/advertisements', to: 'advertisements#show'
  get '/advertisements/:id', to: 'advertisements#show_id'
  get '/advertisements/drafts', to: 'advertisements#show_draft'
  get '/advertisements/:id/comments', to: 'advertisements#show_comments'
  post '/advertisements', to: 'advertisements#create'
  put '/advertisements/:id', to: 'advertisements#update'
  delete '/advertisements/:id', to: 'advertisements#delete'
  #
  get '/comments/:id', to: 'comments#show'
  post '/comments', to: 'comments#create'
  put '/comments/:id', to: 'comments#update'
  delete '/comments/:id', to: 'comments#delete'
end
