class RecipesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @recipes = Recipe.includes(:user).where(user: @user).references(:user)
  end

  def show
  end

  def new
    @user = current_user
    @recipe = @user.recipes.build
  end

  def create
    @user = current_user
    @recipe = @user.recipes.build(recipe_params)

    if @recipe.save
      redirect_to user_recipes_path(@user), notice: 'Created the recipe successfully'
    else
      render :new
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      redirect_to user_recipes_path(current_user)
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name,:preparation_time,:cooking_time,:description)
  end
end
