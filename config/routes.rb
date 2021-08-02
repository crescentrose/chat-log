Rails.application.routes.draw do
  root 'messages#index'

  resources :messages, only: [:index]
  resources :log_files, only: [:create]
end
