class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  belongs_to :invoice
  belongs_to :item
  has_many :bulk_discounts, through: :item


  enum status: [:pending, :packaged, :shipped]

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end

  def find_best_discount
    bulk_discounts
    .where("#{self.quantity} >= minimum")
    .order(percentage: :desc)
    .limit(1)
    .pluck(:id)
    .first
  end

  # def find_best_discount(x)
  #   bulk_discounts
  #   .where("#{x} >= minimum")
  #   .order(percentage: :desc)
  #   .limit(1)
  #   .pluck(:id)
  # end

end
