require 'rails_helper'

RSpec.describe 'Recipes', type: :system do
  include Devise::Test::IntegrationHelpers

  before(:all) do
    Recipe.delete_all
    User.destroy_all

    @user = User.create!(name: 'user3',
                         email: 'user3@mail.com',
                         password: '123456',
                         password_confirmation: '123456',
                         confirmed_at: Time.now)
    @recipe1 = Recipe.create(user: @user,
                             name: 'Pasta',
                             description: 'White Sauce pasta',
                             preparation_time: 30,
                             cooking_time: 40)
    @recipe2 = Recipe.create(user: @user,
                             name: 'Mac n cheese',
                             description: 'American mac n cheese',
                             preparation_time: 30,
                             cooking_time: 50)
    @recipes = Recipe.all
  end

  before(:each) do
    sign_in @user
  end

  it 'I can see the recipes titles' do
    visit user_recipe_path(@user, @recipe1)
    expect(page).to have_content(@recipe1.name)
  end

  it 'I can see the recipes descriptions' do
    visit user_recipe_path(@user, @recipe1)
    expect(page).to have_content(@recipe1.description)
  end

  it 'When I click on a recipe, it takes me to the details' do
    visit user_recipes_path(@user)
    click_on 'Pasta'
    expect(page).to have_current_path(user_recipe_path(@user, @recipe1))
  end
end
