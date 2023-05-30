# frozen_string_literal: true

# interactor for creating checkout
class CreateCheckout < ApplicationInteractor
  delegate :cart, :order_items, :user, :order, :address, :host, :port,
    :discount_name, to: :context

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

    @customer = existing_customer || Stripe::Customer.create(
      email: customer_email,
      name: "#{user.firstname} #{user.lastname}"
    )
  end

  def create_stripe_checkout_session # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    total = total_amount
    discount_amount = 0

    if discount_name
      discount = Discount.find_by(name: discount_name)

      if discount
        discount_amount = (discount.value.to_f / 100) * total
      else
        error(cart.errors.full_messages.to_sentence)
      end
    end

    line_items = [
      {
        price_data: {
          currency: 'pkr',
          product_data: {
            name: order_item.product.title
          },
          unit_amount: (
            total_amount_without_discount(discount_amount) * 100
          ).to_i
        },
        quantity: order_item.quantity
      }
    ]

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: line_items,
      mode: 'payment',
      success_url: r.checkout_orders_url(host: host, port: port),
      cancel_url: r.root_url(host: host, port: port)
    )

    context.session = @session
  end

  def total_amount_without_discount(discount_amount)
    (total_amount - discount_amount).to_f.round(2)
  end

  def total_amount
    order_items.sum do |order_item|
      order_item.product.price * order_item.quantity
    end
  end

  def destroy_cart
    cart.destroy
  end

  def r
    Rails.application.routes.url_helpers
  end

end
