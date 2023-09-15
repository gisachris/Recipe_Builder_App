require 'rails_helper'

RSpec.describe 'Public Recipes List', type: :system do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    # Create users and recipes in the test database
    @user3 = User.create!(name: 'Sandeep',
      email: 'myemail@mymail.com',
      password: 'abcxyz123',
      password_confirmation: 'abcxyz123',
      confirmed_at: Time.now)
    
      @chris = User.create!(name: 'Chris',
        email: 'email@mymail.com',
        password: 'abcxyz123',
        password_confirmation: 'abcxyz123',
        confirmed_at: Time.now)

    Recipe.create(user_id: @user3.id, name: 'Pasta', preparation_time: 30, cooking_time: 40, description: 'White Sauce pasta', public: true)
    Recipe.create(user_id: @chris.id, name: 'Chicken Soup', preparation_time: 10, cooking_time: 45, description: 'Sour Chicken Soup', public: true)

    # Store public recipes in an instance variable for later use
    @public_recipes = Recipe.where(public: true)
  end

  it 'displays the public recipes list' do
    sign_in @user3
    visit user_public_recipes_path(user_id: @user3)  # Use user_public_recipes_path here
    expect(page).to have_content('Public Recipes')
  end

  it 'displays public recipes with their details' do
    # Sign in the user
    sign_in @user3

    # Visit the public recipes page
    visit user_public_recipes_path(user_id: @user3)

    # Iterate through public recipes and check their details
    @public_recipes.each do |recipe|
      expect(page).to have_content(recipe.name)
      expect(page).to have_content("By #{recipe.user.name}")
    end
  end
end
