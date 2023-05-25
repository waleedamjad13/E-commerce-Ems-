require 'stripe'

class CheckoutController < ApplicationController

  def create
    result = CreateCheckout.call(
      cart: @cart,
      order_items: @order_items,
      user: current_user,
      host: request.host,
      port: request.port,
      address: params[:address]
    )
  
    if result.success?
      @order = result.order
      @session = result.session
  
      redirect_to @session.url
    else
      redirect_to cart_path, alert: result.error
    end
  end

  def orders
    @orders = Order.all_orders(current_user)
  end
end
