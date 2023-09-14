class RecipeFoodsController < ApplicationController
  def new
    @user = current_user
    @foods = Food.all
    @recipe = Recipe.find(params[:recipe_id])
    # @recipe_food = RecipeFood.new
  end

  def create
    @user = current_user
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.build(ref_params.merge(recipe_id: @recipe.id))
    respond_to do |format|
      format.html do
        if @recipe_food.save
          redirect_to user_recipe_path(@user, @recipe), notice: 'ingredient was successfully added.'
        else
          render :new
          flash.now[:alert] = 'Ingredient could not be added. Please try again.'
        end
      end
    end
  end

  def destroy
    @user = current_user
    @recipe_food = RecipeFood.find(params[:id]) # Find the Recipe_food item by its own ID
    @recipe = @recipe_food.recipe # Get the associated Recipe

    if @recipe_food.destroy
      redirect_to user_recipe_path(@user, @recipe), notice: 'Food was successfully deleted from the recipe.'
    else
      redirect_to user_recipe_path(@user, @recipe), alert: 'Failed to delete food from the recipe.'
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @recipe_food = RecipeFood.find(params[:id])
    @recipe = @recipe_food.recipe
  end

  def update
    @user = User.find(params[:user_id])
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.quantity = params[:recipe_food][:quantity]

    if @recipe_food.save
      redirect_to user_recipe_path(@user, @recipe_food.recipe), notice: 'Recipe Food was updated successfully'
    else
      render :edit, status: 400
    end
  end

  private

  def ref_params
    params.require(:recipe_food).permit(:quantity, :food_id, :recipe_id)
  end
end
