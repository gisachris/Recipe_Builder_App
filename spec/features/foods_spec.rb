require 'rails_helper'

RSpec.describe 'Recipes', type: :system do
    include Devise::Test::IntegrationHelpers
  
    before(:all) do
      Recipe.delete_all
      Food.delete_all
      User.destroy_all
  
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
      @foods = Food.all
    end
  
    before(:each) do
      sign_in @user
    end
  
    it 'I can see the food names' do
      visit user_foods_path(@user)
      @foods.each do |food|
        expect(page).to have_content(food.name)
      end
    end
  
    it 'I can see the food measurement_units ' do
      visit user_foods_path(@user)
      @foods.each do |food|
        expect(page).to have_content(food.measurement_unit)
      end
    end
  
    it 'I can see the food price' do
      visit user_foods_path(@user)
      @foods.each do |food|
        expect(page).to have_content(food.quantity)
      end
    end
end