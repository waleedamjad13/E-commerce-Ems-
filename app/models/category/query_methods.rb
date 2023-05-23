# frozen_string_literal: true

class Category
  #
  # query methods for category model
  #
  module QueryMethods
    def sorting(column, direction)
      order("#{column} #{direction.upcase}")
    end
  end
end
