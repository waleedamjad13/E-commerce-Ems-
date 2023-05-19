# frozen_string_literal: true


module Admin
  # controller for discounts that are namespaced inside admin
  #
  class DiscountsController < ApplicationController
    before_action :set_discount

    # GET /discounts or /discounts.json
    def index
      @discounts = Discount.all
    end

    # GET /discounts/1 or /discounts/1.json
    def show; end

    # GET /discounts/new
    def new; end

    # GET /discounts/1/edit
    def edit; end

    # POST /discounts or /discounts.json
    def create
      result = CreateDiscount.call(discount_params: discount_params)

      if result.success?
        redirect_to admin_discounts_path,
          notice: 'Discount was successfully created.'
      else
        @discount = result.discount
        render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /discounts/1 or /discounts/1.json
    def update
      result = UpdateDiscount.call(
        discount: @discount,
        discount_params: discount_params
      )

      if result.success?
        redirect_to admin_discount_path(@discount),
          notice: 'discount was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /discounts/1 or /discounts/1.json
    def destroy
      result = DestroyDiscount.call(discount: @discount)

      if result.success?
        redirect_to admin_discounts_path,
          notice: 'Discount was successfully destroyed.'
      else
        flash[:alert] = result.message
        redirect_to admin_discount_path(@discount)
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_discount
        @discount = Discount.find_by(id: params[:id])

        @discount ||= Discount.new
      end

      # Only allow a list of trusted parameters through.
      def discount_params
        params.require(:discount).permit(:name, :value)
      end
  end
end
