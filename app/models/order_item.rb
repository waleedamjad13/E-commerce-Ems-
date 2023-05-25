# frozen_string_literal: true

# model for order item
class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart, optional: true
  belongs_to :order, optional: true 

  def total_price
    quantity * product.price
  end
end
