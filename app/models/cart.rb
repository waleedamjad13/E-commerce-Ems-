# frozen_string_literal: true

# model for cart
class Cart < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  def sub_total
    sum = 0
    order_items.each do |order_item|
      sum += order_item.total_price
    end
    sum
  end
end
