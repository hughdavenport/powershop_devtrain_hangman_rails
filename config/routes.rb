Rails.application.routes.draw do
  resources :games, except: [:create]
  root 'games#index'
end
