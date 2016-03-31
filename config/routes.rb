Rails.application.routes.draw do
  resources :games, only: [:index, :show, :new, :destroy] do
    resources :guesses, only: [:create]
  end
  root 'games#index'
end
