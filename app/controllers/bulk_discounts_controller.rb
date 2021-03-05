class BulkDiscountsController < ApplicationController
  # before_action :find_invoice_and_merchant, only: [:show, :update]
  before_action :find_merchant, only: [:index]
  before_action :find_bulk_discount, only: [:show]

  def index
    @bulk_discounts = @merchant.bulk_discounts
  end

  def show
    @bulk_discount
  end

  # def update
  #   @invoice.update(invoice_params)
  #   redirect_to merchant_invoice_path(@merchant, @invoice)
  # end

  private
  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_bulk_discount
    @bulk_discount = BulkDiscount.find(params[:id])
  end

end
