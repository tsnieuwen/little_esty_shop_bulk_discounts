class BulkDiscount < ApplicationRecord
  validates_presence_of :merchant_id,
                        :percentage,
                        :minimum
  belongs_to :merchant



end
