Rails.application.routes.draw do
  devise_for :users
  resources :artists
  resources :sources
  resources :libraries
  resources :playlists do
    resources :playlist_tracks
    resources :tracks, only: [:new, :create]
  end
  resources :playlist_tracks
  resources :tracks do 
    member do
      get 'play_previous'
      get 'play_next'
    end
  end
  root 'home#index'
  get 'search_type', to: 'home#search_type', as: :search_type
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end
