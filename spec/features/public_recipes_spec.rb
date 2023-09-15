require 'rails_helper'

RSpec.describe 'Public Recipes List', type: :system do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    # Create users and recipes in the test database
    @user3 = User.create(email: 'user3@gmail.com', name: 'user3', password: '123456', password_confirmation: '123456', confirmed_at: Time.now)
    @chris = User.create(email: 'chris@gmail.com', name: 'Chris', password: 'pass007', password_confirmation: 'pass007', confirmed_at: Time.now)

    Recipe.create(user: @user3, name: 'Pasta', preparation_time: 30, cooking_time: 40, description: 'White Sauce pasta', public: true)
    Recipe.create(user: @chris, name: 'Chicken Soup', preparation_time: 10, cooking_time: 45, description: 'Sour Chicken Soup', public: true)

    # Store public recipes in an instance variable for later use
    @public_recipes = Recipe.where(public: true)
  end

  it 'displays the public recipes list' do
    sign_in @user3
    visit public_recipes_path  # Use user_public_recipes_path here
    expect(page).to have_content('Public Recipes List')
  end

  it 'displays public recipes with their details' do
    # Sign in the user
    sign_in @user3

    # Visit the public recipes page
    visit public_recipes_path

    # Iterate through public recipes and check their details
    @public_recipes.each do |recipe|
      expect(page).to have_content(recipe.name)
      expect(page).to have_content("By: #{recipe.user.name}")
    end
  end
end
