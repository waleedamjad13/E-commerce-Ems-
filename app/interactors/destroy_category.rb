# frozen_string_literal: true

# interactor for destroy category
class DestroyCategory < ApplicationInteractor
  delegate :category, to: :context

  def call
    return if category.destroy

    error(category.errors.full_messages.to_sentence)
  end
end
