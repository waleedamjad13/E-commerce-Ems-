# frozen_string_literal: true

# interactor for updating quantity of order items
class UpdateOrderItem < ApplicationInteractor
  delegate :order_item, :add_quantity, :reduce_quantity, to: :context

  def call
    update_quantity
    return if order_item.save

    error(order_item.errors.full_messages.to_sentence)
  end

  private

  def update_quantity
    if add_quantity
      order_item.quantity += 1
    elsif reduce_quantity && order_item.quantity > 1
      order_item.quantity -= 1
    end
  end
end
