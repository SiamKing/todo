Rails.application.routes.draw do
  resources :lists do
    resources :items
  end
  
  resources :users, only: [:new, :create]

  root "lists#index"

  get '/login' => 'sessions#new'
  post '/sessions' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
end
