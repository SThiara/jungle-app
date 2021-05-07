require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    1.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They enter product description page" do
    visit root_path

    find('.actions').click_on('Details')

    sleep 1

    # commented out b/c it's for debugging only
    save_and_open_screenshot

    expect(page).to have_css '.product-detail'
  end
end