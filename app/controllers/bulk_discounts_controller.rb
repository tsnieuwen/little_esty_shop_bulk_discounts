class BulkDiscountsController < ApplicationController
  # before_action :find_invoice_and_merchant, only: [:show, :update]
  before_action :find_merchant, only: [:index]

  def index
    @bulk_discounts = @merchant.bulk_discounts
  end

  # def show
  #   @customer = @invoice.customer
  #   @invoice_item = InvoiceItem.where(invoice_id: params[:id]).first
  # end

  # def update
  #   @invoice.update(invoice_params)
  #   redirect_to merchant_invoice_path(@merchant, @invoice)
  # end

  private
  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

end
