Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  get '/users', to: 'users#show'
  get '/users/:id', to: 'users#show_id'
  get '/users/?:admin=true', to: 'users#show_admins'
  get '/users/:id/advertisements', to: 'users#show_advert'
  get '/users/:id/comments', to: 'users#show_comments'
  post '/users', to: 'users#create'
  put '/users/:id', to: 'users#update'
  delete '/users/:id', to: 'users#delete'
  get '/login', to: 'users#login'
end
