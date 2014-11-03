Rails.application.routes.draw do
  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :goals
  # get '/home', to: 'static_pages#home', as: 'home'
  root to: 'static_pages#home'
end
