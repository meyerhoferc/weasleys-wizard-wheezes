require 'rails_helper'

describe "visitor can adjust items in cart" do
  it "from the cart path" do
    category = Category.create!(name: "potions")
    item = Item.create!(title: "Love Potion",
                        description: "make him love you",
                        price: 11.00,
                        category: category)

    visit root_path
    click_on "Add to Cart"

    visit '/cart'
    within("table") do
      expect(page).to have_content("Love Potion")
      expect(page).to have_content("$11.0")
    end

    within(".total") do
      expect(page).to have_content("$11.0")
    end

    within("table") do
      expect(page).to have_content("1")
    end
    fill_in("session[quantity]", with: 3)
    click_on "Update Cart"

    expect(current_path).to eq('/cart')

    within("table") do
      expect(page).to have_content("3")
    end

    within(".total") do
      expect(page).to have_content("Total: $33.0")
    end

    fill_in("session[quantity]", with: 2)
    click_on "Update Cart"

    expect(current_path).to eq('/cart')

    within("table") do
      expect(page).to have_content("2")
    end

    within(".total") do
      expect(page).to have_content("Total: $22.0")
    end
  end
end