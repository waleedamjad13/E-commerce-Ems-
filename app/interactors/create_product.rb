# frozen_string_literal: true

# interactor for create products
class CreateProduct < ApplicationInteractor
  delegate :product, :product_params, to: :context

  def call
    context.product = Product.new(product_params)
    return if product.save

    error(product.errors.full_messages.to_sentence)
  end
end
