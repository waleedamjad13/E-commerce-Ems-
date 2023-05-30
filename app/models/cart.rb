# frozen_string_literal: true

# model for cart
class Cart < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items

  def calculate_sub_total(discounted_price)
    if discounted_price.present? && discounted_price.positive?
      discounted_price
    else
      sub_total
    end
  end

  def sub_total
    sum = 0
    order_items.each do |order_item|
      sum += order_item.total_price
    end
    sum
  end

  def apply_discount(discount)
    (sub_total * discount.value / 100).round(2)
  end
end
