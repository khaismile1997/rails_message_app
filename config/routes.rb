Rails.application.routes.draw do
  root 'chatroom#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'

  resources :users, except: [:new]

  get 'change_password' => 'users#change_password'
  patch 'update_password' => 'users#update_password'

  # match '*a', :to => 'application#routing_error', via: :get
end