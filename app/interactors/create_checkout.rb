# frozen_string_literal: true

class CreateCheckout < ApplicationInteractor
  delegate :cart, :order_items, :user, :order, to: :context

  def call
    context.order = Order.new(user: user)

    if order.save
      associate_order_items
    else
      error(order.errors.full_messages.to_sentence)
    end
  end

  private

  def associate_order_items
    order_items.each do |order_item|
      order_item.order = order
      order_item.save
    end
  end
end
