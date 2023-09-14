Rails.application.routes.draw do
  get 'shopping_lists/index'
  root 'users#index'
  devise_for :users

  resources :users do
    resources :recipes, only: [:index, :new, :update, :show, :create, :destroy] do
      member do
        patch 'toggle_public', to: 'recipes#toggle_public', as: 'toggle_public'
        # get :add_ingredients, to: 'recipe_foods#add_ingredients', as: 'add_ingredients'
      end
      resources :recipe_foods, only: [:new, :create, :edit, :update, :destroy], as: 'recipejointfoods'
    end
    resources :foods, only: [:index, :new, :create, :destroy]
    resources :shopping_lists, only: :index
  end
end