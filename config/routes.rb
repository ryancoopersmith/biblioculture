Rails.application.routes.draw do
  root 'books#index', as: :authenticated_root
  resources :books, only: [:index]

  devise_for :users

  resources :rooms, only: [:show]

  mount ActionCable.server => '/cable'

  namespace :api do
    namespace :v1 do
      resources :books do
        resources :prices
      end
    end
  end
end
