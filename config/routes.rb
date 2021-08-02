Rails.application.routes.draw do
  resources :messages, only: [:index]
  resources :log_files, only: [:create]
end
