Rails.application.routes.draw do
  get "/users", to: 'users#index', as: :user
  post '/users', to: 'users#create'
  get '/users/new', to: 'users#new', as: :new_user
  get  '/users/:id/edit', to: 'users#edit', as: :edit_user
  post  '/users/:id/update', to: 'users#update', as: :update_user
  get '/users/:id', to: 'users#show', as: :show_user
  get '/login', to: 'users#login', as: :login_user
  post '/rest/login', to: 'users#authentication', as: :authentication_user
  delete '/users/:id/destroy', to: 'users#destroy', as: :destroy_user
end
