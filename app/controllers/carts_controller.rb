# frozen_string_literal: true

# controller for carts
class CartsController < ApplicationController
  before_action :set_products, only: [:create]

  def create
    result = CreateCart.call(product: @product, user: current_user,
      order_items_params: [{ product: @product }])

    if result.success?
      redirect_to cart_path(result.cart), notice: 'Product added to cart.'
    else
      redirect_to product_path(product), alert: result.error
    end
  end

  def show
    @cart = current_user.cart
    @order_items = @cart.order_items if @cart.present?
    @publishable_key = Rails.configuration.stripe[:publishable_key]
    @discounted_price = params[:discounted_price].to_f
    @sub_total = @cart.present? ? @cart.calculate_sub_total(@discounted_price) : 0
  end
  


  private

  def set_products
    @product = Product.find(params[:product_id])
  end
end
