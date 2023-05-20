# frozen_string_literal: true

# model for discount
class DiscountProducts < ApplicationRecord
  belongs_to :discount
  belongs_to :product
end