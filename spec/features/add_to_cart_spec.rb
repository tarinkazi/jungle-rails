require 'rails_helper'

RSpec.feature "Visitor adds products to cart", type: :feature, js: true do

  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )      
    end
  end

  scenario "User sees cart number increase in the top nav" do
    visit root_path

    find_button("Add", match: :first).trigger("click")
    expect(page).to have_content('My Cart (1)')
    save_screenshot 
    puts page.html
  end

end