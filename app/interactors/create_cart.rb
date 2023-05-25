# frozen_string_literal: true

# interactor for creating cart
class CreateCart < ApplicationInteractor
  delegate :cart, :product, :user, to: :context

  def call
    context.cart = prepare_cart

    if cart.save
      create_order_items
      
    else
      error(cart.errors.full_messages.to_sentence)
    end
  end

  private

  def prepare_cart
    Cart.find_or_initialize_by(user: user)
  end

  def create_order_items
    context.order_items_params.each do |order_item_params|
      cart.order_items.create(order_item_params)
    end
  end
end
