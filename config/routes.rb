# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'products#index'
  resources :products
  resources :carts, only: :index do
    resources :items, only: %i[create destroy], controller: :cart_items
  end
  post 'city_list', to: 'orders#city_list'
  resources :orders
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
