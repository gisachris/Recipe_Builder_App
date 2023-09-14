class RecipesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @recipes = Recipe.includes(:user).where(user: @user).references(:user)
  end

  def show
    @user = current_user
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.recipe_foods
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
    return unless @recipe.destroy

    redirect_to user_recipes_path(current_user)
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    return unless @recipe.user == current_user

    @recipe.update_column(:public, !@recipe.public)
    redirect_to user_recipe_path(@recipe.user, @recipe), notice: 'Recipe status updated.'
  end

  def add_ingredient
    @recipe = Recipe.find(params[:id]) # Find the recipe you want to add ingredients to
    @foods = Food.all # Fetch a list of available foods (ingredients)
    @recipe_food = RecipeFood.new # Initialize a new RecipeFood object for the form
  end
  
  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description)
  end
end
