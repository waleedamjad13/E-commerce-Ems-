# frozen_string_literal: true

class Product
  #
  # file for query methods for user model
  #
  module QueryMethods
    def all_products(user)
      return Product.all if user&.admin?

      where(status: 'publish')
    end

    def search(search_terms)
      search_condition = "title LIKE :term OR price = :price_term"
      where(search_condition, term: "%#{search_terms}%", price_term: search_terms.to_i)
    end
  end
end
