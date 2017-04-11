Rails.application.routes.draw do

  root 'books#index', as: :authenticated_root
  resources :books
  
  devise_for :users
 

