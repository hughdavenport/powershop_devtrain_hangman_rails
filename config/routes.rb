Rails.application.routes.draw do
  resources :word_lists
  resources :games, only: [:new, :index, :show, :create, :destroy] do
    resources :guesses, only: [:create]
  end
  root 'games#index'
end
