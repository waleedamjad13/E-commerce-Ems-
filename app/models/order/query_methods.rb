# frozen_string_literal: true

class Order
  #
  # file for query methods for user model
  #
  module QueryMethods
    def all_orders(user)
      if user&.admin?
        Order.all
      else
        where(user: user)
      end
    end

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
end
