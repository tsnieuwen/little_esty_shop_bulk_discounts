require 'rails_helper'

describe "merchant bulk discounts new" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')

    @bulk_discount1 = BulkDiscount.create!(percentage: 0.2, minimum: 16, merchant_id: @merchant1.id)
    @bulk_discount2 = BulkDiscount.create!(percentage: 0.1, minimum: 11, merchant_id: @merchant1.id)
    @bulk_discount3 = BulkDiscount.create!(percentage: 0.06, minimum: 6, merchant_id: @merchant2.id)
  end

  it "has a submit button, and field were you can enter in new bulk discount parameters" do
    visit new_merchant_bulk_discount_path(@merchant1)

    expect(page).to have_content("Percentage:")
    expect(page).to have_content("Minimum # of Items:")
    expect(page).to have_button("Submit")
  end

  it "creates a new bulk discount for that merchant, and redirects to the merchant bulk discounts index after filling out field and hitting submit" do
    visit new_merchant_bulk_discount_path(@merchant1)

    fill_in :percentage, with: 50
    fill_in :minimum, with: 10
    click_button("Submit")
    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
    expect(page).to have_content("50.0%")
    expect(page).to have_content("10 item or more")
  end

  it "renders a message prompting correct input if percentage is outside 0 to 100" do
    visit new_merchant_bulk_discount_path(@merchant1)

    fill_in :percentage, with: 101
    fill_in :minimum, with: 10
    click_button("Submit")
    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
    expect(page).to have_content("Discount not created. Please enter a percentage from 0 - 100, and a whole number greater than or equal to one for the minimum number of items")
  end

  it "renders a message prompting correct input if threshold is not a whole number greater than 0" do
    visit new_merchant_bulk_discount_path(@merchant1)

    fill_in :percentage, with: 98
    fill_in :minimum, with: "tacos"
    click_button("Submit")
    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
    expect(page).to have_content("Discount not created. Please enter a percentage from 0 - 100, and a whole number greater than or equal to one for the minimum number of items")
  end

  it "renders a message prompting correct input if threshold is not a whole number greater than 0" do
    visit new_merchant_bulk_discount_path(@merchant1)

    fill_in :percentage, with: 98
    fill_in :minimum, with: 0
    click_button("Submit")
    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
    expect(page).to have_content("Discount not created. Please enter a percentage from 0 - 100, and a whole number greater than or equal to one for the minimum number of items")
  end
end
