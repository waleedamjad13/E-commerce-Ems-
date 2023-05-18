# frozen_string_literal: true

# interactor for update product
class UpdateProduct < ApplicationInteractor
  delegate :product, :product_params, to: :context

  def call
    return if product.update(product_params)

    error(product.errors.full_messages.to_sentence)
  end
end
