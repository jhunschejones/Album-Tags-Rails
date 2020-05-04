Rails.application.routes.draw do
  # providing custom behavior for devise controllers
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :users, only: [:show]
  resources :albums, only: [:show]
  resources :tags, only: [:index]

  get '/search', to: 'static_pages#search', as: 'search'
  root to: 'static_pages#home'
end
