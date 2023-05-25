class Order < ApplicationRecord
  extend QueryMethods
  belongs_to :user
  has_many :order_items, dependent: :destroy

  def sub_total
    sum = 0
    order_items.each do |order_item|
      sum += order_item.total_price
    end
    sum
  end
end
