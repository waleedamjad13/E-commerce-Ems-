# frozen_string_literal: true

class CreateCheckout < ApplicationInteractor
  delegate :cart, :order_items, :user, :order, :address, :host, :port, to: :context

  def call
    fetch_cart
    create_order
    create_stripe_customer
    create_stripe_checkout_session
    destroy_cart
  end

  private

  def fetch_cart
    context.cart = user.cart
    context.order_items = cart.order_items
    context.publishable_key = Rails.configuration.stripe[:publishable_key]
  end

  def create_order
    result = CreateOrder.call(
      user: user,
      address: address,
      order_items: order_items
    )

    if result.success?
      context.order = result.order
    else
      error(order.errors.full_messages.to_sentence)
    end
  end

  def associate_order_items
    order_items.each do |order_item|
      order_item.order = order
      order_item.save
    end
  end

  def create_stripe_customer
    customer_email = user.email
    existing_customer = Stripe::Customer.list(email: customer_email).data.first

    @customer = if existing_customer
                  existing_customer
                else
                  Stripe::Customer.create(
                    email: customer_email,
                    name: "#{user.firstname} #{user.lastname}"
                  )
                end
  end

  def create_stripe_checkout_session
    line_items = order.order_items.map do |order_item|
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
  
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: line_items,
      mode: 'payment',
      success_url: r.checkout_orders_url(host: host, port: port),
      cancel_url: r.root_url(host: host, port: port)
    )

    context.session = @session
  end
  

  def destroy_cart
    cart.destroy
  end

  def r
    Rails.application.routes.url_helpers
  end

end
