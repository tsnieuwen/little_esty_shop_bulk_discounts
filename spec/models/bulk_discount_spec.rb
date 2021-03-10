require 'rails_helper'

describe BulkDiscount do

  describe "validations" do
    it { should validate_presence_of :merchant_id }
    it { should validate_presence_of :percentage }
    it { should validate_presence_of :minimum }
    it { should validate_numericality_of(:percentage).is_greater_than_or_equal_to(0)}
    it { should validate_numericality_of(:percentage).is_less_than_or_equal_to(1)}
    it { should validate_numericality_of(:minimum).is_greater_than_or_equal_to(1)}
  end

  describe "relationships" do
    it { should belong_to :merchant }
  end

end
