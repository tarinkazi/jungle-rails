require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "should save a valid product" do
      @category = Category.create(name: 'Shoes')
      @product = Product.new(
        name: "Chic",
        price_cents: 8000,
        quantity: 12,
        category_id: @category.id
      )
      expect(@product).to be_valid
      expect(@product.errors.full_messages).to be_empty
    end

    it "should not save without a name" do
      @category = Category.create(name: 'Shoes')
      @product = Product.new(
        name: nil,
        price_cents: 8000,
        quantity: 12,
        category_id: @category.id
      )
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include "Name can't be blank"
    end

    it "should not save without price" do
      @category = Category.create(name: 'Shoes')
      @product = Product.new(
        name: "Chic",
        price_cents: nil,
        quantity: 12,
        category_id: @category.id
      )
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include "Price can't be blank"
    end

    it "should not save without quantity" do
      @category = Category.create(name: 'Shoes')
      @product = Product.new(
        name: "Chic",
        price_cents: 8000,
        quantity: nil,
        category_id: @category.id
      )
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include "Quantity can't be blank"
    end

    it "should not save without category id" do
      @category = Category.create(name: 'Shoes')
      @product = Product.new(
        name: "Chic",
        price_cents: 8000,
        quantity: 12,
        category_id: nil
      )
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include "Category can't be blank"
    end

  end
end