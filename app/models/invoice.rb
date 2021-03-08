class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :items

  enum status: [:cancelled, :in_progress, :complete]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  # def save_money
  #   # Invoice.joins(:invoice_items, :items, :bulk_discounts)
  #
  #     # joins(:bulk_discounts)
  #   invoice_items.joins(:bulk_discounts)
  #   .where('invoice_items.quantity >= bulk_discounts.minimum')
  #   .select("invoice_items.*, bulk_discounts.minimum, invoice_items.quantity * invoice_items.unit_price * bulk_discounts.percentage as savings")
  #   .order("bulk_discounts.percentage desc")
  # end

  def save_money
    invoice_items.joins(:bulk_discounts)
    .where('invoice_items.quantity >= bulk_discounts.minimum')
    .select("invoice_items.item_id, MAX(invoice_items.quantity * invoice_items.unit_price * bulk_discounts.percentage)")
    .group("invoice_items.item_id")
  end

  def total_savings
    save_money.sum(&:max)
  end

  def find_discount
    invoice_items.joins(:bulk_discounts)
    .where('invoice_items.quantity >= bulk_discounts.minimum')
    .select("invoice_items.item_id, MAX(bulk_discounts.percentage)")
    .group("invoice_items.item_id")
  end
  # def save_money
  #   # Invoice.joins(:invoice_items, :items, :bulk_discounts)
  #   invoice_items.joins(:bulk_discounts)
  #   .where('invoice_items.quantity >= bulk_discounts.minimum')
  #   .select("invoice_items.item_id, invoice_items.unit_price, bulk_discounts.id as discount_id, MAX(bulk_discounts.percentage), invoice_items.quantity * invoice_items.unit_price * bulk_discounts.percentage as savings")
  #   .group("invoice_items.item_id")
  #   .distinct
  #   # .group("invoice_items.item_id")
  # end



end

# invoice_items.joins(:bulk_discounts)
# .where('invoices.id = 29 AND invoice_items.quantity >= bulk_discounts.minimum')
# .select("invoice_items.item_id as item_id, invoices.id, invoice_items.quantity, invoice_items.unit_price, items.merchant_id, bulk_discounts.id as discount_id, MAX(bulk_discounts.percentage), bulk_discounts.minimum, invoice_items.quantity * invoice_items.unit_price * bulk_discounts.percentage as savings")
