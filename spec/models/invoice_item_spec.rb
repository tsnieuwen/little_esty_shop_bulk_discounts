require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "validations" do
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
  end
  describe "relationships" do
    it { should belong_to :invoice }
    it { should belong_to :item }
    it { should have_many(:bulk_discounts).through(:item) }
  end

  describe "instance methods" do
    it "find best discount" do
      BulkDiscount.destroy_all
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @bulk_discount1 = BulkDiscount.create!(percentage: 0.3, minimum: 8, merchant_id: @merchant1.id)
      @bulk_discount2 = BulkDiscount.create!(percentage: 0.4, minimum: 7, merchant_id: @merchant1.id)
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 8, unit_price: 10, status: 2)

      expect(@ii_1.find_best_discount).to eq(@bulk_discount2.id)
    end
  end
end
