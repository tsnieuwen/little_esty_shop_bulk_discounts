class BulkDiscount < ApplicationRecord
  validates_presence_of :merchant_id,
                        :percentage,
                        :minimum
  validates_numericality_of :percentage, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 1
  validates_numericality_of :minimum, :greater_than_or_equal_to => 1

  belongs_to :merchant



end
