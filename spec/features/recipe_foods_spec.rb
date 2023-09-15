require 'rails_helper'

RSpec.describe 'Recipes', type: :system do
  include Devise::Test::IntegrationHelpers

  before(:all) do
    RecipeFood.delete_all
    Recipe.delete_all
    Food.delete_all
    User.destroy_all
  end

  before(:each) do
    @user = User.create!(name: 'Sandeep',
                         email: 'sandeep@mymail.com',
                         password: 'abcxyz123',
                         password_confirmation: 'abcxyz123',
                         confirmed_at: Time.now)

    @food1 = Food.create(
      user: @user,
      name: 'Test Food 101',
      measurement_unit: 'Gram',
      price: 9.99,
      quantity: 10
    )

    @food2 = Food.create(
      user: @user,
      name: 'Test Food 102',
      measurement_unit: 'Gram',
      price: 9.99,
      quantity: 10
    )

    @recipe = Recipe.create(user: @user,
                            name: 'Chicken Soup',
                            description: 'Delicious hot and sour chicken soup',
                            preparation_time: 10,
                            cooking_time: 45)

    sign_in @user
  end

  scenario 'User creates a new recipe food' do
    visit user_recipe_path(@user, @recipe)

    select @food1.name, from: 'recipe_food[food_id]'
    fill_in 'Quantity', with: 10

    click_button 'Create food'

    expect(page).to have_content(@food1.name)
    expect(page).to have_content(10)
  end
end
