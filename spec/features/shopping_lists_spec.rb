require 'rails_helper'

RSpec.describe 'ShoppingLists', type: :system do
  include Devise::Test::IntegrationHelpers

  before(:all) do
    Food.delete_all
    Recipe.delete_all

    @chris = User.find_or_create_by(email: 'chris@gmail.com') do |user|
      user.name = 'Chris'
      user.password = 'pass007'
      user.password_confirmation = 'pass007'
      user.confirmed_at = Time.now
    end

    @recipe1 = Recipe.create(user: @chris,
                             name: 'Chicken Soup',
                             description: 'Sour Chicken Soup',
                             preparation_time: 10,
                             cooking_time: 45)

    @food1 = Food.create(user: @chris,
                         name: 'Pasta',
                         measurement_unit: 'grams',
                         price: 10.0,
                         quantity: 5)

    @food2 = Food.create(user: @chris,
                         name: 'Mac n Cheese',
                         measurement_unit: 'units',
                         price: 75.0,
                         quantity: 7)
  end

  before(:each) do
    sign_in @chris
  end

  it 'displays the total value of food needed' do
    visit user_shopping_lists_path(@chris)
    expect(page).to have_content('Total Value Of Food Needed: $0')
  end

  it 'displays the total number of food items to buy' do
    visit user_shopping_lists_path(@chris)
    expect(page).to have_content('Amount of Food Items To Buy:')
  end
end
