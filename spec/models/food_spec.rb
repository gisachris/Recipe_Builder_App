require 'rails_helper'

RSpec.describe Food, type: :model do
  before(:each) do
    @user = User.create!(name: 'Sandeep',
    email: 'sandeep@mymail.com',
    password: 'abcxyz123',
    password_confirmation: 'abcxyz123',
    confirmed_at: Time.now)
    
    @food = Food.create(
      user_id: @user.id,
      name: 'Test Food 101',
      measurement_unit: 'Gram',
      price: 9.99,
      quantity: 10
    )
  end

    describe 'validations' do
      it 'is valid with valid attributes' do
        expect(@food).to be_valid
      end
  
      it 'is not valid without a name' do
        @food.name = nil
        expect(@food).to be_valid
      end
  
      it 'is not valid without a measurement_unit' do
        @food.measurement_unit = nil
        expect(@food).to be_valid
      end
  
      it 'is not valid without a price' do
        @food.price = nil
        expect(@food).to be_valid
      end
  
      it 'is not valid without a quantity' do
        @food.quantity = nil
        expect(@food).to be_valid
      end
    end
  end