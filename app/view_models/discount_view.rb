# frozen_string_literal: true

# UserView class for discount show
#
class DiscountView < ApplicationView
  alias discount model

  delegate :id, :name, :value, to: :discount
end
