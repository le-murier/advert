Rails.application.routes.draw do

  get '/users', to: 'users#show'
  get '/users/:id', to: 'users#show_id'
  get '/admins', to: 'users#show_admins'
  get '/users/test', to: 'users#test'
  post '/users', to: 'users#create'
  post '/login', to: 'users#login'
  put '/users/:id', to: 'users#update'
  delete '/users/:id', to: 'users#delete'


    #GET /advertisements/?sort=date ?
  get '/advertisements', to: 'advertisements#show'
  get '/advertisements/:id', to: 'advertisements#show_id'
  get '/advertisements/drafts', to: 'advertisements#show_draft'
  get '/advertisements/:id/comments', to: 'advertisements#show_comments'
  post '/advertisements', to: 'advertisements#create'
  put '/advertisements/:id', to: 'advertisements#update'
  delete '/advertisements/:id', to: 'advertisements#delete'
end
