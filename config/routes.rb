Rails.application.routes.draw do
  root 'users#index'
  devise_for :users

  resources :users do
  resources :recipes, only: [:index, :show]
  resources :foods, only: [:index, :new, :create, :destroy]
  resources :recipe_foods, only: [:index, :show]
  resources :shopping_list, only: :index
  end
end
