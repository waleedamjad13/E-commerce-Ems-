# frozen_string_literal: true

class Discount
  #
  # file for query methods for discount model
  #
  module QueryMethods
    def search(search_terms)
      search_condition = 'name LIKE :term OR value = :value_term'
      where(search_condition, term: "%#{search_terms}%",
        value_term: search_terms.to_i)
    end
  end
end
