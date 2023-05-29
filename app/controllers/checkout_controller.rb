# frozen_string_literal: true

require 'stripe'

# controller for checkout
class CheckoutController < ApplicationController
  def create # rubocop:disable Metrics/AbcSize
    result = CreateCheckout.call(
      cart: @cart,
      order_items: @order_items,
      user: current_user,
      host: request.host,
      port: request.port,
      address: params[:address],
      discount_name: params[:discount_name]
    )

    if result.success?
      @order = result.order
      @session = result.session
      redirect_to @session.url
    else
      redirect_to cart_path(current_user), alert: result.error
    end
  end
end
