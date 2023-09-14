class ShoppingListsController < ApplicationController
  def index
    @user = current_user
    @total_foods = 0
    @total_price = 0
    @recipe_foods = []
    @user.recipes.each do |recipe|
      recipe.recipe_foods.each do |recipe_food|
        @total_foods += 1
        @total_price += recipe_food.food.price * recipe_food.quantity
        @recipe_foods << recipe_food
      end
    end
  end
end
