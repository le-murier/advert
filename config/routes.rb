Rails.application.routes.draw do

  get '/users', to: 'users#show'
  get '/users/:id', to: 'users#show_id'
  get '/admins', to: 'users#show_admins'
  get '/test', to: 'users#test'
  post '/users', to: 'users#create'
  post '/login', to: 'users#login'
  put '/users/:id', to: 'users#update'
  delete '/users/:id', to: 'users#delete'
end
