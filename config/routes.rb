Rails.application.routes.draw do
  root 'users#index'
  devise_for :users

  resources :users do
    resources :recipes, only: [:index, :new, :update, :show, :create, :destroy] do
      member do
        patch 'toggle_public', to: 'recipes#toggle_public', as: 'toggle_public'
      end
      resources :recipe_foods, only: [:new, :create, :edit, :update, :destroy], as: 'recipejointfoods'
    end
    resources :foods, only: [:index, :new, :create, :destroy]
    resources :public_recipes, only: [:index]
    resources :shopping_lists, only: :index
  end
end