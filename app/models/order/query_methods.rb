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
  end
end
