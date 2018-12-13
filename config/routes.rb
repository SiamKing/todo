Rails.application.routes.draw do
  resources :users, only: [:new, :create] do
      resources :lists do
        resources :items, only: [:new, :create, :update, :destroy]
    end
  end

  root "users#new"

  get '/login' => 'sessions#new'
  post '/sessions' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
end
