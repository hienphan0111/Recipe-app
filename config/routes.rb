Rails.application.routes.draw do
  devise_for :users

  resources :foods, only: [:index, :new, :create, :destroy]

  resources :inventories, only: [:index, :show, :new, :create, :destroy] do
    resources :inventory_foods, only: [:new, :create, :destroy]
  end

  resources :recipes, only: [:index, :show, :new, :create] do
    resources :recipe_foods, only: [:new, :create, :destroy]
    get '/shopping_list', to: 'recipes#shopping_list'
    put '/', to: 'recipes#toggle_public'
  end

  put 'recipes/:id', to: 'recipes#remove_food'

  

  authenticated :user do
    root 'recipes#index', as: :authenticated_root
  end

  unauthenticated :user do
    root 'recipes#public_recipes', as: :unauthenticated_root
  end
end
