# frozen_string_literal: true

class Product
  #
  # file for query methods for user model
  #
  module QueryMethods


    def all_products(user)
      return Product.all if user&.admin?
      where(status: "publish")
    end
    
  end

end
