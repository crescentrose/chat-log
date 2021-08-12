Rails.application.routes.draw do
  root 'messages#index'

  resources :messages, only: [:index, :show]
  resources :votekick_events, only: [:index]
  resources :connection_events, only: [:index]
  resources :log_files, only: [:create]
  resources :users, only: [:index, :destroy]

  post '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'
  delete '/auth', to: 'sessions#destroy', as: :logout
end
