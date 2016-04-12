Rails.application.routes.draw do
  root 'games#index'
  resources :games, only: [:new, :index, :show, :create, :destroy] do
    resources :guesses, only: [:index, :create]
  end
  resources :word_lists, only: [:new, :edit, :index, :show, :create, :update, :destroy] do
    resources :words, only: [:new, :index, :create, :destroy]
  end
end
