class BulkDiscountsController < ApplicationController
  # before_action :find_invoice_and_merchant, only: [:show, :update]
  before_action :find_merchant, only: [:index, :new, :create, :show, :edit, :update]
  before_action :find_bulk_discount, only: [:show, :edit, :update]

  def index
    @bulk_discounts = @merchant.bulk_discounts.order(minimum: :desc)
    @holidays ||= HolidayService.upcoming_holidays
  end

  def show
    @bulk_discount
    @merchant
  end

  def new
    @merchant
  end

  def edit
  end

  def update
    @bulk_discount.update(percentage: (params[:percentage].to_f/100), minimum: params[:minimum])
    redirect_to merchant_bulk_discount_path(@merchant, @bulk_discount)
  end

  def create
    BulkDiscount.create!(percentage: (params[:percentage].to_f/100),
                        minimum: params[:minimum],
                        merchant_id: params[:merchant_id])
    redirect_to "/merchant/#{params[:merchant_id]}/bulk_discounts"
  end

  def destroy
    BulkDiscount.destroy(params[:id])
    redirect_to "/merchant/#{params[:merchant_id]}/bulk_discounts"
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
