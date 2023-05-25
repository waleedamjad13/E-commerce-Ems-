require 'stripe'

class CheckoutController < ApplicationController
  def create
    @cart = current_user.cart
    @order_items = @cart.order_items
    @publishable_key = Rails.configuration.stripe[:publishable_key]

    result = CreateCheckout.call(cart: @cart, order_items: @order_items, user: current_user)

    if result.success?
      @order = result.order
      line_items = @order.order_items.map do |order_item|
        {
          price_data: {
            currency: 'pkr',
            product_data: {
              name: order_item.product.title
            },
            unit_amount: (order_item.product.price * 100).to_i
          },
          quantity: order_item.quantity
        }
      end

      customer_email = current_user.email
      existing_customer = Stripe::Customer.list(email: customer_email).data.first

      if existing_customer
        @customer = existing_customer
      else
        @customer = Stripe::Customer.create(
          email: customer_email,
          name: "#{current_user.firstname} #{current_user.lastname}"
        )
      end

      @session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: line_items,
        mode: 'payment',
        success_url: checkout_orders_url,
        cancel_url: root_url
      )
      @cart.destroy

    else
      redirect_to cart_path, alert: result.error
    end
  end

  

  def orders
    @orders = Order.all_orders(current_user)
  end
  
end