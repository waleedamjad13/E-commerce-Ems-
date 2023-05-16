# frozen_string_literal: true

class User
  #
  # file for query methods for user model
  #
  module QueryMethods
    def search_by_name(search_terms)
      where(
        'firstname LIKE :term OR lastname LIKE :term OR email LIKE :term',
        term: "%#{search_terms}%"
      )
    end
  end
end
