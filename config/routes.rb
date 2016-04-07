Rails.application.routes.draw do
  resources :games, only: [:new, :index, :show, :create, :destroy] do
    resources :guesses, only: [:create]
  end
  root 'games#index'
end
