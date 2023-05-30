# frozen_string_literal: true

class Product
  #
  # file for query methods for user model
  #
  module QueryMethods
    def all_products(user)
      return Product.all if user&.admin?

      joins(:category)
        .where(status: 'publish', categories: { active: true })
    end

    def search(search_terms, user)
      if user.admin?
        query = 'title LIKE :term OR price = :price_term OR
                 status = :status_term'
      end

      where(
        query,
        term: "%#{search_terms}%",
        price_term: search_terms.to_i,
        status_term: Product.statuses[search_terms.downcase]
      )
    end
  end
end
