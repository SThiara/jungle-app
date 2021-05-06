require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @category = Category.new(name: "Test Category")
  end

  describe 'Validations' do
    it 'will succeed if all parameters are provided' do
      @product = Product.new(name: "Test", price: 5, quantity: 1, category: @category)
      expect(@product).to be_valid
    end
    it 'will fail if no name is provided' do
      @product = Product.new(price: 5, quantity: 1, category: @category)
      expect(@product).to_not be_valid
    end

    it 'will fail if no price is provided' do
      @product = Product.new(name: "Test", quantity: 1, category: @category)
      expect(@product).to_not be_valid
    end

    it 'will fail if no quantity is provided' do
      @product = Product.new(price: 5, name: "Test", category: @category)
      expect(@product).to_not be_valid
    end

    it 'will fail if no category is provided' do
      @product = Product.new(price: 5, quantity: 1, name: "Test")
      expect(@product).to_not be_valid
    end
  end
end
