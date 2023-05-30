# frozen_string_literal: true

# model for discount and rproducts thrird table
class DiscountProduct < ApplicationRecord
  belongs_to :product
  belongs_to :discount
end
