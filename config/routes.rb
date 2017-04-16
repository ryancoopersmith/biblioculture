Rails.application.routes.draw do
  root 'books#index', as: :authenticated_root
  resources :books, only: [:index]

  devise_for :users

  resources :rooms, only: [:new, :create, :show, :index]

  mount ActionCable.server => '/cable'

  namespace :api do
    namespace :v1 do
      resources :books, only: [:index, :show] do
        resources :prices, only: [:index, :show]
      end
    end
  end

  resources :terms, only: [:index]
  resources :privacy, only: [:index]
end
