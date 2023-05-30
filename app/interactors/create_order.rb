# frozen_string_literal: true

# interactor for creating order
class CreateOrder < ApplicationInteractor
  delegate :user, :address, :order_items, :order, to: :context

  def call
    create_order
    associate_order_items
  end

  private

  def create_order
    context.order = Order.new(user: user, address: address)

    if order.save
      context.success = true
    else
      context.error = order.errors.full_messages.to_sentence
    end
  end

  def associate_order_items
    order_items.each do |order_item|
      order_item.order = order
      order_item.save
    end
  end
end
