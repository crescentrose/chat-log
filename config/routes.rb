require 'sidekiq/web'
require 'admin_constraint'

Rails.application.routes.draw do
  root 'messages#index'

  resources :connection_events, only: [:index]
  resources :messages, only: %i[index show]
  resources :roles
  resources :users, only: %i[index update create]
  resources :server_groups, only: %i[index update create destroy]
  resources :votekick_events, only: [:index]

  resources :flags, only: %[:destroy] do
    get :resolve, on: :member
  end

  resources :servers do
    get :admin, on: :collection
  end

  post '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'
  delete '/auth', to: 'sessions#destroy', as: :logout
  post '/upload', to: 'log_files#create'
  get '/bonca', to: 'stats#index'

  mount Sidekiq::Web => '/sidekiq', constraints: AdminConstraint.new
  mount ActionCable.server => '/cable'
end
