require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    
    it 'product is created successfully when all four fields are set' do
      category = Category.new(name: 'Big Tree')
      product = Product.new(name: 'Super Green', price_cents: 999, quantity: 99, category: category)
      expect(product.save).to be_truthy
    end

    it 'should fail if name is nil' do
      category = Category.new(name: 'Big Tree')
      product = Product.new(name: nil, price_cents: 999, quantity: 99, category: category)
      product.save
      # need product.save first, without the save, there will be no `errors`
      expect(product.errors.full_messages).to include("Name can't be blank")
    end
    

    it 'should fail if price is nil' do
      category = Category.new(name: 'Big Tree')
      product = Product.new(name: 'Super Green', price_cents: nil, quantity: 99, category: category)
      product.save
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    it 'should fail if quantity is nil' do
      category = Category.new(name: 'Big Tree')
      product = Product.new(name: "Super Green", price_cents: 999, quantity: nil, category: category)
      product.save
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end
    
    it 'should fail if category is nil' do
      product = Product.new(name: "Super Green", price_cents: 999, quantity: 99, category: nil)
      product.save
      expect(product.errors.full_messages).to include("Category can't be blank")
    end

  end
end