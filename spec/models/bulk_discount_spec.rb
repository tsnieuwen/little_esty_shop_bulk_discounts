require 'rails_helper'

describe BulkDiscount do

  describe "validations" do
    it { should validate_presence_of :merchant_id }
    it { should validate_presence_of :percentage }
    it { should validate_presence_of :minimum }
  end

  describe "relationships" do
    it { should belong_to :merchant }
  end

end
