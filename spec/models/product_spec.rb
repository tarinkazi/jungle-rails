require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'creates a product with all four fields set.' do
      @cat = Category.find_or_create_by! name: 'Furniture'
      @cat.save
      @prod = Product.new name: 'chair', category: @cat, price: 10, quantity: 3
      @prod.save
      expect(@prod).to be_valid
    end
    it 'throws an error if no name in product' do
      @cat = Category.find_or_create_by! name: 'Furniture'
      @cat.save
      @prod = Product.new name: nil, category: @cat, price: 10, quantity: 3
      @prod.save
      expect(@prod.errors.full_messages).to include "Name can't be blank"
    end
    it 'throws an error if no category in product' do
      @cat = Category.find_or_create_by! name: 'Furniture'
      @cat.save
      @prod = Product.new name: 'chair', category: nil, price: 10, quantity: 3
      @prod.save
      expect(@prod.errors.full_messages).to include "Category can't be blank"
    end
    it 'throws an error if no price in product' do
      @cat = Category.find_or_create_by! name: 'Furniture'
      @cat.save
      @prod = Product.new name: 'chair', category: @cat, quantity: 3
      @prod.save
      expect(@prod.errors.full_messages).to include "Price can't be blank"
    end
    it 'throws an error if no quantity in product' do
      @cat = Category.find_or_create_by! name: 'Furniture'
      @cat.save
      @prod = Product.new name: 'chair', category: @cat, price: 10, quantity: nil
      @prod.save
      expect(@prod.errors.full_messages).to include "Quantity can't be blank"
    end
  end
end