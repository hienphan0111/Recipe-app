Rails.application.routes.draw do
  devise_for :users
  # , :controllers => { :registrations => 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # resources :users do
  #   resources :posts
  # end
  root 'foods#show'

  resources :foods, only: [:index, :show, :create, :destroy]
  resources :inventories, only: [:index, :show, :create, :destroy]
end
