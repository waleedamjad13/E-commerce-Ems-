# frozen_string_literal: true

# model for discount
class Discount < ApplicationRecord
  extend QueryMethods

  has_many :discount_products
  has_many :products, through: :discount_products
end
