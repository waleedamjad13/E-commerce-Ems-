# frozen_string_literal: true

# model for discount
class Discount < ApplicationRecord
  extend QueryMethods

  has_and_belongs_to_many :products
end
