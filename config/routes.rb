Rails.application.routes.draw do
  resources :games, except: [:create] do
    resources :guesses
  end
  root 'games#index'
end
