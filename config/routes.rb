Rails.application.routes.draw do
  # providing custom behavior for devise controllers
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :users, only: [:show]
  resources :albums, only: [:show] do
    get 'connections', to: 'albums#edit_connections'
    post 'connections', to: 'albums#add_connection'
    delete 'connections/:connection_apple_album_id', to: 'albums#remove_connection'

    get 'tags', to: 'albums#edit_tags'
    post 'tags', to: 'albums#add_tag'
    delete 'tags/:tag_id', to: 'albums#remove_tag'

    get 'lists', to: 'albums#edit_lists'
    post 'lists', to: 'albums#add_to_list'
    delete 'lists/:list_id', to: 'albums#remove_from_list'
  end
  resources :tags, only: [:index]
  get "/search_by_tag", to: 'tags#search_by_tag'

  get '/search', to: 'static_pages#search', as: 'search'
  root to: 'static_pages#home'
end
