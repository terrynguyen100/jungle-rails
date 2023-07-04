require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    category = Category.new(name: 'Big Tree') 

    it 'creates a product successfully when all four fields are set' do
      product = Product.new(name: 'Super Green', price_cents: 999, quantity: 99, category: category)

      expect(product.save).to be_truthy
    end

    it 'fails to create a product when name is nil' do
      product = Product.new(name: nil, price_cents: 999, quantity: 99, category: category)

      expect(product.save).to be_falsy
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'fails to create a product when price is nil' do
      product = Product.new(name: 'Super Green', price_cents: nil, quantity: 99, category: category)

      expect(product.save).to be_falsy
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    it 'fails to create a product when quantity is nil' do
      product = Product.new(name: 'Super Green', price_cents: 999, quantity: nil, category: category)

      expect(product.save).to be_falsy
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'fails to create a product when category is nil' do
      product = Product.new(name: 'Super Green', price_cents: 999, quantity: 99, category: nil)

      expect(product.save).to be_falsy
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
