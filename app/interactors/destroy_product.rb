class DestroyProduct < ApplicationInteractor
  delegate :product, to: :context

  def call
    return if product.destroy

    error(product.errors.full_messages.to_sentence)
  end
end
