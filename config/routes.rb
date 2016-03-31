Rails.application.routes.draw do
  resources :games, except: [:create] do
    resources :guesses, only: [:create]
  end
  root 'games#index'
end
