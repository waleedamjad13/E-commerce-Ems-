# frozen_string_literal: true

# model for order
class Order < ApplicationRecord
  extend QueryMethods
  belongs_to :user
  has_many :order_items, dependent: :destroy
  belongs_to :discount, optional: true


  validates :address, presence: true

  def sub_total
    sum = 0
    order_items.each do |order_item|
      sum += order_item.total_price
    end
    sum
  end


  def discounted_total_price
    total_price = sub_total
    discount_amount = discount ? (discount.value.to_f / 100) * total_price : 0
    (total_price - discount_amount).to_f.round(2)
  end

end
