Rails.application.routes.draw do

  root 'books#index', as: :authenticated_root
  resources :books

  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :books
    end
  end
end
