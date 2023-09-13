class RecipesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @recipes = Recipe.includes(:user).where(user: @user).references(:user)
  end
end
