Rails.application.routes.draw do
  resources :messages, only: [:index] do
    post :upload
  end
end
