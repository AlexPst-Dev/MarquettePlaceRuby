Rails.application.routes.draw do
  resources :orders, only: [:create]
  resources :products do
    resources :orders, only: [:create]
  end
  resources :buyers
  resources :sellers
  resources :users, only: [:new, :create]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  get 'register', to: 'users#new'
  post 'register', to: 'users#create'

  post 'toggle_role', to: 'users#toggle_role'

  root 'products#index'
end
