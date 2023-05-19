# frozen_string_literal: true

# model for category
class Category < ApplicationRecord
  has_many :products
end
