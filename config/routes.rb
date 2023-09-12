Rails.application.routes.draw do
  root 'users#index'
  devise_for :users

  resources :users do
  resources :recipes, except: :update
  resources :foods, except: :update
  resources :shopping_list, only: :index
  end
end
